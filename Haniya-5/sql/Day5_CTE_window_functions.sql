--================================================================================
--CLASS 5: CTEs, PIVOT, EXPRESSIONS & WINDOW FUNCTIONS (Beginners Edition)
--Duration: 3 Hours
--Database: BikeStores Sample Database
--Prerequisites: Basic SELECT, WHERE, JOIN, GROUP BY
--================================================================================


--PART 1: CASE Expressions 
------------------------------------------------

--**Basic Structure:**
--CASE
--    WHEN condition1 THEN result1
--    WHEN condition2 THEN result2
--    ELSE default_result
--END

--**Example 1: Convert numbers to words (Super Simple)**
-- Order status in BikeStores is stored as 1,2,3,4
-- Let's make it readable:

SELECT 
    order_id,
    order_status,
    CASE 
        WHEN order_status = 1 THEN 'Pending'
        WHEN order_status = 2 THEN 'Processing'
        WHEN order_status = 3 THEN 'Rejected'
        WHEN order_status = 4 THEN 'Completed'
        ELSE 'Unknown'
    END AS status_description
FROM sales.orders;

--**Example 2: Price categories (Very Simple)**
SELECT 
    product_name,
    list_price,
    CASE 
        WHEN list_price < 500 THEN 'Budget'
        WHEN list_price < 2000 THEN 'Mid-Range'
        WHEN list_price < 5000 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_tier
FROM production.products;

-- **Example 3: Simple CASE (when checking one column for equality)**
-- Shortcut for when you're checking a single column:
SELECT 
    product_name,
    model_year,
    CASE model_year
        WHEN 2024 THEN 'New Arrival'
        WHEN 2023 THEN 'Last Year'
        ELSE 'Older Model'
    END AS year_category
FROM production.products;




-- Pro Tip: Always include ELSE. Without ELSE, anything not matched becomes NULL.

-- Practice Exercise for Students:
-- Create a query that shows customer email, and a column called "email_status" 
-- that shows 'Has Email' if email is NOT NULL, else 'Missing Email'



-- PART 2: CTE - Common Table Expressions (40 min)
-------------------------------------------------------------

-- Basic Syntax:
--WITH any_name_you_want AS (
    -- Your query here
--)
-- SELECT * FROM any_name_you_want;

-- Example 1: Extremely Simple CTE
-- Without CTE (normal query):
-- build a CTE for only expensive products 


-- Example 2: CTE makes complex queries readable
-- WITHOUT CTE (hard to read):
-- SELECT PRODUCTS WHERE PRODUCT PRICE IS GREATER THAN AVERAGE PRICE

-- Example 3: Using CTE multiple times (where CTEs shine!) 
-- Find brands that have more than 5 products 
-- Without CTE, you'd have to write the same subquery twice:


-- Example 4: Multiple CTEs in one query

-- Customers who never ordered


-- Important: CTEs don't run faster! They are for ORGANIZATION, not performance.

-- Practice:
-- Write a CTE that finds the average order value per customer, 
-- then use it to find customers who spend above average.


-- PART 3: Window Functions - Basics (40 min)
--------------------------------------------------------
--Window functions are SCARY at first, but very simple once understood.

 -- Window Function Analogy: 
-- Imagine a classroom of students with test scores:
-- GROUP BY = "Show me the class average" (1 row)
-- Window Function = "Show each student's score AND the class average next to it" (all rows)

-- Basic Syntax:
-- AVG(column) OVER (PARTITION BY group_column)

-- Example 1: Compare each product to its brand average 
 SELECT 
    product_name,
    brand_id,
    list_price,
    AVG(list_price) OVER (PARTITION BY brand_id) AS brand_average_price
FROM production.products;

-- Now you can see each product's price vs its brand's average!

-- Example 2: ROW_NUMBER() - just numbering rows
-- Give each product a number (1,2,3...)


-- Number within each brand:


-- Example 3: RANK() vs ROW_NUMBER()
-- If two products have same price:

-- ROW_NUMBER: 1,2,3,4... (always unique)
-- RANK: 1,1,3,4... (same price = same rank, then skips)

-- Example 5: LAG - look at previous row**
-- Compare each order with the customer's previous order:
SELECT 
    customer_id,
    order_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date
FROM sales.orders;

-- This shows: "Your last order was on [date]"

**Key Window Function Summary:**
| Function | What it does |
|----------|--------------|
| ROW_NUMBER() | Assigns 1,2,3... to each row |
| RANK() | Like row_number but ties get same number |
| SUM() OVER | Running total |
| AVG() OVER | Moving average |
| LAG() | Get previous row's value |
| LEAD() | Get next row's value |

-- Practice:
-- Use ROW_NUMBER() to find the most expensive product in each category

[2:40 - 3:00] PART 4: PIVOT - Rows to Columns (20 min)
------------------------------------------------------
PIVOT turns row values into column headers (like Excel's pivot table).

**Current Data (rows):**
Store    | Status    | Count
Store A  | Pending   | 10
Store A  | Completed | 25
Store B  | Pending   | 5
Store B  | Completed | 30

**After PIVOT (columns):**
Store    | Pending | Completed
Store A  | 10      | 25
Store B  | 5       | 30

**Basic Syntax:**
SELECT *
FROM (your query here) AS SourceTable
PIVOT (
    AGGREGATE_FUNCTION(column_to_aggregate)
    FOR column_to_pivot IN ([value1], [value2], [value3])
) AS PivotTable;

**Example 1: Simple PIVOT (order status by store)**
-- First, see the data in row format:
SELECT 
    store_id,
    order_status,
    COUNT(*) AS order_count
FROM sales.orders
GROUP BY store_id, order_status
ORDER BY store_id, order_status;

-- Now pivot it:
SELECT *
FROM (
    SELECT store_id, order_status, order_id
    FROM sales.orders
) AS SourceTable
PIVOT (
    COUNT(order_id)
    FOR order_status IN ([1], [2], [3], [4])
) AS PivotTable;

-- Better: Add meaningful column names:
SELECT 
    store_id,
    [1] AS Pending,
    [2] AS Processing,
    [3] AS Rejected,
    [4] AS Completed
FROM (
    SELECT store_id, order_status, order_id
    FROM sales.orders
) AS SourceTable
PIVOT (
    COUNT(order_id)
    FOR order_status IN ([1], [2], [3], [4])
) AS PivotTable;

**Example 2: PIVOT with totals**
-- Sales by year for each store:
SELECT *
FROM (
    SELECT 
        s.store_name,
        YEAR(o.order_date) AS sale_year,
        oi.quantity * oi.list_price * (1 - oi.discount) AS sales_amount
    FROM sales.stores s
    JOIN sales.orders o ON s.store_id = o.store_id
    JOIN sales.order_items oi ON o.order_id = oi.order_id
) AS SourceTable
PIVOT (
    SUM(sales_amount)
    FOR sale_year IN ([2021], [2022], [2023], [2024])
) AS PivotTable;

**When to use PIVOT:**
- Creating reports for management (they love column-based reports!)
- Building dashboards
- Exporting to Excel

**Limitations:**
- You must know the column names in advance ([2021], [2022], etc.)
- For dynamic columns (unknown years), you need advanced dynamic SQL

[3:00 - 3:15] SUMMARY & CHEAT SHEET (15 min)
--------------------------------------------

**QUICK REFERENCE - When to use what:**

| Problem | Solution |
|---------|----------|
| Need IF-THEN-ELSE logic | CASE |
| Need to reuse a subquery | CTE (WITH ... AS) |
| Need ranking (1st, 2nd, 3rd) | ROW_NUMBER() |
| Need running total | SUM() OVER (ORDER BY date) |
| Need previous row's value | LAG() |
| Need category average next to each row | AVG() OVER (PARTITION BY category) |
| Need rows as columns (report) | PIVOT |

**Common Mistakes to Avoid:**
❌ Forgetting ELSE in CASE (returns NULL for unhandled cases)
❌ Thinking CTEs are temporary tables (they're not - they disappear after query)
❌ Using ROW_NUMBER() without ORDER BY (results are unpredictable)
❌ Forgetting the ORDER BY in LAG/LEAD (which row is "previous"?)
