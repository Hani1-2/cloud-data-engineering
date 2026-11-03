-- ============================================
-- SQL Server — Class 4 Homework
-- BikeStores Sample Database
-- Topics: SELECT · Filtering · JOIN · GROUP BY
-- ============================================

-- Q1: Show product name, model year, and list price for all products
-- from model year 2017 or 2018 whose name contains the word 'Electra'.
-- Sort by product name.

-- Q2: Find customers who have a phone number on file AND an email
-- ending in '@yahoo.com'. Show full name, email, and city.
-- Sort by city, then by last name.

-- Q3: For orders placed in 2017 that have already shipped, show order ID,
-- order date, shipped date, and a computed column "Days To Ship"
-- (days between order date and shipped date).
-- Show only the 10 slowest shipments.

-- Q4: List all products that are OUT OF STOCK (quantity = 0) at the
-- store "Baldwin Bikes". Show product name, brand name, and quantity.
-- Sort by product name.

-- Q5: For orders placed in 2018, show order ID, customer full name,
-- product name, and the discounted line total
-- (quantity × list_price × (1 – discount)) for every order item with
-- a discount of 20% or more. Sort by line total descending.

-- Q6: Find all staff members who have NEVER handled an order.
-- Show staff full name and the name of their store.

-- Q7: Find all customers who have bought at least one product from
-- the brand "Trek". Show each customer's full name and city once only.
-- Sort by full name.

-- Q8: Using CROSS JOIN, generate every possible combination of
-- store name and category name. Sort by store name, then category name.

-- Q9: Show the total number of units sold for each product category.
-- Display category name and total units. Sort by total units descending.

-- Q10: Show the number of orders placed per store per year.
-- Display store name, order year, and order count.
-- Sort by store name, then year.

-- Q11: For each staff member, count the orders they handled.
-- Show staff full name and order count, but only for staff who handled
-- MORE THAN 100 orders. Sort by order count descending.

-- Q12: Find customers whose total spending
-- (SUM of quantity × list_price × (1 – discount)) is above $10,000.
-- Show customer full name and total spent (rounded to 2 decimals).
-- Sort by total spent descending.

-- Q13: For each brand, show the average and maximum list price.
-- Keep only brands whose average price is above $1,000.
-- Show brand name, average price (2 decimals), and max price.
-- Sort by average price descending.

-- Q14: Show the total quantity in stock for each store and category
-- combination. Display store name, category name, and total quantity.
-- Sort by store name, then by total quantity descending.

-- Q15 (BONUS): For the year 2017, show for each month:
-- month number, number of orders, and total revenue
-- (quantity × list_price × (1 – discount), rounded to 2 decimals).
-- Sort by month number.