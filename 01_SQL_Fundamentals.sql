-- =====================================================================
-- 01 | SQL FUNDAMENTALS
-- Project : Olist Brazilian E-Commerce Analysis (MySQL 8)
-- Goal    : Get to know the orders and customers tables before analysing
--           them: sizes, statuses, missing values, and basic filters.
-- Tip     : Run one query at a time (Ctrl+Enter). Write a one-line
--           INSIGHT under each query after you see the result.
-- =====================================================================

USE olist_ecommerce;


-- QUERY 1 | How many orders are in the dataset?
SELECT COUNT(*) AS total_orders
FROM orders;
-- INSIGHT:


-- QUERY 2 | Which order statuses exist?
SELECT DISTINCT order_status
FROM orders
ORDER BY order_status;
-- INSIGHT:


-- QUERY 3 | What does the orders table look like? (preview)
SELECT *
FROM orders
LIMIT 10;
-- INSIGHT:


-- QUERY 4 | How many orders were canceled, and what share of all orders is that?
SELECT COUNT(*) AS canceled_orders,
       ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM orders), 2) AS pct_of_all_orders
FROM orders
WHERE order_status = 'canceled';

-- 4b | Preview of the canceled orders themselves
SELECT order_id, customer_id, order_status, order_purchase_timestamp
FROM orders
WHERE order_status = 'canceled'
ORDER BY order_purchase_timestamp DESC
LIMIT 20;
-- INSIGHT:


-- QUERY 5 | How many orders were placed from 2018 onwards, month by month?
SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS purchase_month,
       COUNT(*) AS orders
FROM orders
WHERE order_purchase_timestamp >= '2018-01-01'
GROUP BY purchase_month
ORDER BY purchase_month;

-- 5b | Preview of the individual orders
SELECT order_id, order_status, order_purchase_timestamp
FROM orders
WHERE order_purchase_timestamp >= '2018-01-01'
ORDER BY order_purchase_timestamp
LIMIT 20;
-- INSIGHT:


-- QUERY 6 | Which orders have no delivery date, and why? (breakdown by status)
-- Note: if the delivery column was imported as text, missing dates can be
-- stored as empty strings instead of NULL, so both cases are checked.
SELECT order_status,
       COUNT(*) AS orders_without_delivery_date
FROM orders
WHERE order_delivered_customer_date IS NULL
   OR order_delivered_customer_date = ''
GROUP BY order_status
ORDER BY orders_without_delivery_date DESC;
-- INSIGHT:


-- QUERY 7 | What are the 20 most recent orders?
SELECT order_id, order_status, order_purchase_timestamp
FROM orders
ORDER BY order_purchase_timestamp DESC
LIMIT 20;
-- INSIGHT:


-- QUERY 8 | How many customers are in the state of Sao Paulo (SP)?
-- Note: customer_id is created per ORDER, so the same person can have
-- several customer_id values. customer_unique_id identifies the real person.
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers_sp,
       COUNT(*) AS customer_records_sp
FROM customers
WHERE customer_state = 'SP';

-- 8b | Preview of SP customers
SELECT customer_id, customer_unique_id, customer_city, customer_state
FROM customers
WHERE customer_state = 'SP'
LIMIT 20;
-- INSIGHT:
