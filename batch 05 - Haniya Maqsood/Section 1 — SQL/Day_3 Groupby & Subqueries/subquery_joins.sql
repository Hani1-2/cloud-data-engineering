  -- Find all orders placed by customers who live in California

select o.*
from [sales].[orders] o
inner join [sales].[customers] c
on c.customer_id = o.customer_id
where c.state = 'CA'


-------- SUB QUERY
SELECT *
FROM [sales].[orders]
WHERE CUSTOMER_ID IN 
(
SELECT CUSTOMER_ID
FROM [sales].[customers]
WHERE STATE = 'CA'
)

--  Staff who handled more than 50 orders 
SELECT staff_id, COUNT(*) COUNT_OF_ORDERS
FROM [sales].[orders]
GROUP BY staff_id
having COUNT(*) > 50


-- FIND ALL PRODUCTS WHERE CATEGORY NAME IS ROAD BIKES
  
select * from [sales].[stores]
where
store_id in
(SELECT distinct [store_id]
  FROM [bikestores].[production].[stocks]
  where quantity < 10)


  -- give me store name where product stock is less than 10
  select * from [sales].[stores]
	where
	store_id in
  (SELECT store_id
  FROM [bikestores].[production].[stocks]
  group by store_id, product_id
  having sum(quantity) < 10)

select * from [production].[products]
  where product_id in 
  (SELECT product_id
  FROM [bikestores].[production].[stocks]
  group by store_id, product_id
  having sum(quantity) < 10)