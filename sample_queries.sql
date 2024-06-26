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
USE sql_store;

-- INNER JOIN --
SELECT order_id, oi.product_id, p.name, oi.quantity, oi.unit_price FROM order_items oi JOIN products p ON oi.product_id=p.product_id;

-- self join --
USE sql_hr;

SELECT e.employee_id, e.first_name, m.first_name AS manager FROM
employees e JOIN employees m ON e.reports_to=m.employee_id;

-- multiple table joins --
USE sql_invoicing;

SELECT p.date, p.invoice_id, p.amount, c.name AS client_name, pm.name AS payment_method FROM 
payments p JOIN clients c ON p.client_id= c.client_id 
JOIN payment_methods pm ON p.payment_method=pm.payment_method_id;

-- compound join (composite keys) --
USE sql_store;

SELECT * FROM order_items oi JOIN order_item_notes oin ON oi.order_id = oin.order_id AND oi.product_id=oin.product_id;

-- outer joins --
-- left all items from product--
 --  right all items from order items--
SELECT p.product_id, p.name AS product_name, oi.quantity 
FROM products p 
	LEFT JOIN order_items  oi
	ON p.product_id = oi.product_id;

SELECT o.order_date, o.order_id, c.first_name , sh.name AS shipper_name , os.name AS order_status
FROM orders o 
	LEFT JOIN customers c ON o.customer_id=c.customer_id
    LEFT JOIN shippers sh ON o.shipper_id=sh.shipper_id
    LEFT JOIN order_statuses os ON o.status = os.order_status_id;
    
    -- self outer join --
    USE sql_hr;
    SELECT e.employee_id, e.first_name,m.first_name as manager
    FROM employees e 
    LEFT JOIN employees m ON e.reports_to=m.employee_id;
    
    -- using clause use instead of on if column names are same --
    -- we can pass multiple columns by comma in using if composite key is there --
    USE sql_invoicing;
    SELECT p.date, c.name AS client, p.amount, pm.name AS payment_method
    FROM payments p JOIN clients c USING(client_id)
    JOIN payment_methods pm ON p.payment_method=pm.payment_method_id;
    
    -- natural join not recommended --
    -- joins based on same column names --
    USE sql_store;
    SELECT o.order_id, c.first_name FROM orders o NATURAL JOIN customers c;
    
    -- cross join every record from  each table --
    SELECT sh.name AS shipper, p.name AS product FROM shippers sh, products p ORDER BY sh.name;
    -- explicit way--
        SELECT sh.name AS shipper, p.name AS product FROM shippers sh CROSS JOIN products p ORDER BY sh.name;

-- union combine records from multiple queries --
SELECT customer_id, first_name,points, 'BRONZE' as type from customers where points<2000
UNION 
SELECT customer_id, first_name,points, 'SILVER' as type from customers where points BETWEEN 2000 AND 3000
UNION
SELECT customer_id, first_name,points, 'GOLD' as type from customers where points>3000 ORDER BY first_name;

