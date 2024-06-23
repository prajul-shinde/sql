-- ************* Retrieving from single table*************** --
 -- covers various clauses and operators --
USE sql_store;
SELECT name, unit_price, (unit_price*1.1) AS new_price from products;
SELECT * FROM orders WHERE order_date>='2019-01-01';
SELECT * FROM order_items WHERE order_id = 6 AND ((quantity*unit_price)>30);
SELECT * FROM products WHERE quantity_in_stock IN (49,38,72);
SELECT * FROM customers WHERE  birth_date BETWEEN '1990-01-01' AND '2000-01-01';
SELECT * FROM customers WHERE address LIKE '%TRAIL%' OR address LIKE '%AVENUE%';
SELECT * FROM customers WHERE phone LIKE '%9';
-- REGEX--
-- Beginning ^
-- End $
-- | logical or 
-- [abcd] match any of these characters
-- [-] represent range

SELECT * FROM customers WHERE first_name REGEXP 'ELKA|AMBUR';
SELECT * FROM customers WHERE last_name REGEXP 'EY$|ON$';
SELECT * FROM customers WHERE last_name REGEXP '^MY|SE';
SELECT * FROM customers WHERE last_name REGEXP 'B[RU]';
SELECT * FROM orders WHERE shipper_id IS NULL ;
SELECT *, unit_price*quantity AS total_price  FROM order_items WHERE order_id=2 ORDER BY total_price DESC;
SELECT * FROM customers ORDER BY points DESC LIMIT 3;
-- order of clauses  select -> from -> where -> order by -> limit


-- ***********Retrieving Data from multiple tables************ -- 

