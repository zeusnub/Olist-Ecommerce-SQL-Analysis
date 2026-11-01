-- =====================================================================
-- 02 | AGGREGATIONS AND FILTERING
-- Project : Olist Brazilian E-Commerce Analysis (MySQL)
-- =====================================================================


-- QUERY 9 | How many orders fall under each order status?
SELECT order_status,
       COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY COUNT(*) DESC;


-- QUERY 10 | What is the average payment value recorded per payment transaction?
SELECT ROUND(AVG(payment_value), 2) AS average_payment
FROM order_payments;


-- QUERY 11 | What is the total payment value recorded across all transactions?
SELECT ROUND(SUM(payment_value), 2) AS total_payments
FROM order_payments;


-- QUERY 12 | Which payment methods are used most frequently by customers?
SELECT payment_type,
       COUNT(*) AS total_transactions
FROM order_payments
GROUP BY payment_type
ORDER BY COUNT(*) DESC;


-- QUERY 13 | Which Brazilian states have the highest number of customers?
SELECT customer_state,
       COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY COUNT(*) DESC;


-- QUERY 14 | How many products belong to each product category?
SELECT product_category_name,
       COUNT(*) AS total_products
FROM products
GROUP BY product_category_name
ORDER BY COUNT(*) DESC;


-- QUERY 15 | Which sellers have sold more than 50 items?
SELECT seller_id,
       COUNT(*) AS total_items_sold
FROM order_items
GROUP BY seller_id
HAVING COUNT(*) > 50
ORDER BY COUNT(*) DESC;


-- QUERY 16 | How many customer reviews does each rating (1-5 stars) receive?
SELECT review_score,
       COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY total_reviews DESC;
