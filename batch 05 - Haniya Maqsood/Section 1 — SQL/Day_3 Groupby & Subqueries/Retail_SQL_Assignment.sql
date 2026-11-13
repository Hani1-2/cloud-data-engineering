/*
SQL ANALYTICS ASSIGNMENT
Database: BikeStores-style SQL Server database
Schema: sales and production

STUDENT INSTRUCTIONS
1. Write one SQL query for each task below.
2. Use the supplied database schema. Do not create or alter tables.
3. Use readable aliases and format calculated columns clearly.
4. Where a business rule is not specified, state your assumption in a SQL comment.
5. Submit your queries in the same order as the questions.

SCHEMA REFERENCE
Sales:
  sales.customers
  sales.staffs
  sales.stores
  sales.orders
  sales.order_items

Production:
  production.categories
  production.products
  production.stocks
  production.brands

KEY RELATIONSHIPS
  orders.customer_id  -> customers.customer_id
  orders.store_id     -> stores.store_id
  orders.staff_id     -> staffs.staff_id
  order_items.order_id -> orders.order_id
  order_items.product_id -> products.product_id
  products.category_id -> categories.category_id
  products.brand_id    -> brands.brand_id
  stocks.store_id      -> stores.store_id
  stocks.product_id    -> products.product_id

REVENUE DEFINITION
For this assignment, line-item revenue is:
  quantity * list_price * (1 - discount)

Unless a question says otherwise, use completed orders only
(orders.order_status = 4) when calculating sales revenue.

============================================================
QUESTION 1 — MONTHLY SALES
============================================================
Create a monthly sales report showing:
- Month (year and month)
- Total revenue
- Number of orders
- Total units sold
- Average order value (AOV)
- Month-over-month (MoM) revenue growth percentage

Requirements:
- Count each order once.
- Calculate AOV as monthly revenue divided by the number of orders.
- Show MoM growth as a percentage.
- For the first month, where no previous month exists, return NULL for MoM growth.
- Sort the result chronologically.

============================================================
QUESTION 2 — STORE PERFORMANCE
============================================================
Create a store performance report showing:
- Store name
- Total revenue
- Number of unique customers
- Average order value (AOV)
- Revenue share as a percentage of total revenue
- Revenue rank by store (highest revenue = rank 1)

Requirements:
- Use completed orders only.
- Count each customer once per store.
- Calculate AOV using the number of unique orders.
- Sort by revenue from highest to lowest.

============================================================
QUESTION 3 — PRODUCT PERFORMANCE
============================================================
Create a product performance report showing:
- Product name
- Brand
- Category
- Total revenue
- Overall revenue rank
- Revenue rank within the product's category
- Total stock on hand across all stores
- A flag identifying products with no sales

Requirements:
- Include every product, including products that have never sold.
- A product with no completed-order sales must have revenue 0.
- Rank products by revenue, highest first.
- Use appropriate window functions for the overall and category rankings.
- Do not allow products with no sales to disappear because of an INNER JOIN.

============================================================
QUESTION 4 — CATEGORY AND BRAND SALES
============================================================
Create a report showing:
- Category name
- Brand name
- Total revenue

Requirements:
- Aggregate completed-order revenue by category and brand.
- Include only category/brand combinations with sales.
- Sort by category and then revenue from highest to lowest.

============================================================
QUESTION 5 — CUSTOMER VALUE SEGMENTS
============================================================
Segment customers into the following four groups:
- Top
- At risk (high value)
- Recent (lower spend)
- Lapsed

Return:
- Customer ID
- Customer full name
- Lifetime revenue
- Most recent order date
- Days since most recent order
- Customer segment

Business rules to use:
- Calculate each customer's lifetime revenue from completed orders.
- Define a high-value customer as one whose lifetime revenue is greater than or equal to the average lifetime revenue of customers who have completed at least one order.
- Top: high-value customer whose most recent completed order was within the last 90 days.
- At risk (high value): high-value customer whose most recent completed order was 91–365 days ago.
- Recent (lower spend): customer whose most recent completed order was within the last 90 days but who is not high value.
- Lapsed: customers with no completed orders, or whose most recent completed order was more than 365 days ago.
- Use the current date when calculating days since the most recent order.

============================================================
QUESTION 6 — STAFF PERFORMANCE
============================================================
Create a staff sales report showing:
- Staff ID
- Staff full name
- Store name
- Number of completed orders handled
- Total revenue generated

Requirements:
- Use completed orders only.
- Include staff members even if they have not handled a completed order.
- Show zero orders and zero revenue where applicable.
- Sort by revenue from highest to lowest.

============================================================
QUESTION 7 — SHIPPING PERFORMANCE
============================================================
Create a shipping performance report by store and order month showing:
- Store name
- Order month
- Number of shipped orders
- Average days to ship
- On-time shipping percentage

Definitions:
- A shipped order has a non-NULL shipped_date.
- Days to ship = DATEDIFF(day, order_date, shipped_date).
- An order is on time when shipped_date is on or before required_date.
- On-time percentage = on-time shipped orders / all shipped orders * 100.
- Group by store and the month in which the order was placed.
- Exclude orders that have not shipped from the shipping calculations.

============================================================
QUESTION 8 — INVENTORY HEALTH
============================================================
Create an inventory health report for each store and product showing:
- Store name
- Product ID
- Product name
- Quantity currently in stock
- Units sold during the last 30 days
- Average units sold per day during the last 30 days
- Days of stock cover
- Inventory health label

Use these labels:
- Out of stock
- Low stock
- Healthy
- Overstocked

Business rules:
- Use the stock quantity from production.stocks.
- Calculate sales velocity using completed orders from the last 30 days.
- Average daily units sold = units sold in the last 30 days / 30.
- Days of stock cover = current stock / average daily units sold.
- Out of stock: stock quantity = 0.
- Low stock: more than 0 days of stock cover and fewer than 14 days.
- Healthy: 14 to 60 days of stock cover, inclusive.
- Overstocked: more than 60 days of stock cover.
- If stock is greater than 0 but there were no sales in the last 30 days, label it Overstocked and return NULL for days of stock cover.
- Include all store/product stock records, including products with no sales.

END OF ASSIGNMENT
