-- ============================================================
-- DAY 04 / 30  |  Date: 4 October 2026 (Sunday)
-- 30 Days SQL Challenge  |  PostgreSQL
-- ============================================================

/* IBM Data Analyst SQL Question
Q.1
Customer Segmentation Problem:
You have two tables: customers and orders.

customers table has columns: 
  customer_id, customer_name, age, gender.
orders table has columns: 
order_id, customer_id, order_date, total_amount.


Write an SQL query to find the average order amount 
for male and female customers separately
return the results with 2 DECIMAL.
*/





-- ----------------------------------------------
-- My solution
-- ----------------------------------------------





-- Sample schema and data (added so this file runs on its own)
DROP TABLE IF EXISTS customers CASCADE;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

INSERT INTO customers (customer_id, customer_name, age, gender) VALUES
(1, 'Rahim', 28, 'Male'),
(2, 'Karim', 35, 'Male'),
(3, 'Ayesha', 31, 'Female'),
(4, 'Nusrat', 26, 'Female'),
(5, 'Tanvir', 42, 'Male'),
(6, 'Sadia', 39, 'Female');

DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-10', 120.50),
(2, 1, '2023-02-15', 80.00),
(3, 2, '2023-03-05', 200.00),
(4, 3, '2023-03-20', 150.75),
(5, 4, '2023-04-11', 95.25),
(6, 5, '2023-05-02', 310.00),
(7, 6, '2023-05-18', 180.00),
(8, 3, '2023-06-07', 60.00);

SELECT * FROM customers;
SELECT * FROM orders;

-- avg spent
-- by gender
-- join both table

SELECT 
	c.gender as gender_name,
	ROUND(avg(o.total_amount), 2) as avg_spent
FROM customers as c
JOIN orders as o
ON c.customer_id = o.customer_id
GROUP BY gender_name;














/*
Q.2 You have been given a table named sales with the following columns:

order_id (unique identifier for each order)
order_date (date when the order was placed)
product_id (unique identifier for each product)
quantity (the quantity of the product ordered in that particular order)
price_per_unit (the price per unit of the product)

Write an SQL query to find out the total sales revenue generated for each month in the year 2023.
*/




-- Create the sales table
DROP TABLE IF EXISTS sales CASCADE;
CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    product_id INT,
    quantity INT,
    price_per_unit DECIMAL(10, 2)
);

-- Insert sample values into the sales table
INSERT INTO sales (order_id, order_date, product_id, quantity, price_per_unit)
VALUES
    (1, '2022-03-10', 101, 2, 15.00),
    (2, '2022-04-05', 102, 1, 25.50),
    (3, '2023-01-15', 103, 3, 10.75),
    (4, '2023-02-20', 104, 2, 30.20),
    (5, '2022-05-12', 105, 4, 12.80),
    (6, '2023-06-18', 106, 2, 22.40),
    (7, '2023-07-22', 107, 1, 45.30),
    (8, '2021-08-30', 108, 3, 20.60);


/*
Q.2 You have been given a table named sales with the following columns:

order_id (unique identifier for each order)
order_date (date when the order was placed)
product_id (unique identifier for each product)
quantity (the quantity of the product ordered in that particular order)
price_per_unit (the price per unit of the product)

Write an SQL query to find out the total sales revenue generated for each month in the year 2023.
*/





-- ----------------------------------------------
-- My solution
-- ----------------------------------------------




-- total_sales
-- by month (group by)
-- filter 2023


SELECT 
	TO_CHAR(order_date, 'month') as month_name,
	SUM(price_per_unit * quantity) as revene
FROM sales
WHERE EXTRACT(YEAR FROM order_date) = '2023'
GROUP BY month_name
ORDER BY 
	EXTRACT(MONTH FROM MIN(order_date));
