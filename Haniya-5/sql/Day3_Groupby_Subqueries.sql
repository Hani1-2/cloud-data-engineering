 --Common aggregate functions:
 -- COUNT(*)          — total number of rows in the group
 -- COUNT(col)        — rows where col is NOT NULL
 -- SUM(col)          — sum of values
 -- AVG(col)          — average value
 -- MIN(col)          — smallest value
 -- MAX(col)          — largest value
-- CONCEPT
-- GROUP BY


-- Q1: How many products does each brand have? 


-- Q2: SUM and AVG per category 

-- Q3: Count orders per customer


-- Q4: Which store generated the most revenue? 
-- Four-table JOIN with GROUP BY

-- GROUP BY MULTIPLE COLUMNS
-- Products sold per brand per model year — how has each brand's catalog grown?

-- Q6: Average price per brand 

-- Q7: Total orders and revenue per staff member 

-- Q8: Orders per year 

-- Q9: Stock quantity per store

-- Q10: Products per model year 


-- HAVING CONCEPT
-- BRANDS WITH MORE THAN 20 PRODUCTS


-- ── Q12: WHERE + HAVING together ─────────────────────────────
--        Among 2018 products only,
--        which categories have an average price over $1,000?


-- CUSTOMERS WHO PLACED 2 OR MORE ORDERS


-- Q14: Brands with avg price between $500 and $1,500 


-- Q15: Stores with more than 200 total units in stock

-- Q16: Categories with more than 5 products from 2016 

-- Q17: Staff who handled more than 50 orders 

-- SUBQUERIES
-- Find all products priced above the average price of all products

-- Find all orders placed by customers who live in California


-- EXISTS   — returns TRUE if the subquery returns at least one row. Does NOT return data, just a yes/no.


-- EXISTS: CUSTOMERS WHO HAVE PLACED AT LEAST ONE ORDER


-- NOT EXISTS: CUSTOMERS WITH NO ORDERS

-- Q25: Products that have never been ordered 

-- Q26: Stores that have at least one completed order 