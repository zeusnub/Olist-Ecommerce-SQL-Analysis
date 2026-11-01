-- =====================================================================
-- 03 | JOINS AND BUSINESS ANALYSIS
-- Project : Olist Brazilian E-Commerce Analysis (MySQL)
-- =====================================================================


-- QUERY 17 | Retrieve orders with customer information
SELECT o.order_id,
       o.customer_id,
       o.order_status,
       c.customer_city,
       c.customer_state
FROM orders AS o
INNER JOIN customers AS c
        ON o.customer_id = c.customer_id
LIMIT 20;


-- QUERY 18 | Which product categories generate the highest revenue for Olist?
SELECT p.product_category_name,
       ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
INNER JOIN products AS p
        ON oi.product_id = p.product_id
GROUP BY product_category_name
ORDER BY total_revenue DESC;


-- QUERY 19 | Which 10 sellers generate the highest revenue for Olist?
SELECT s.seller_id,
       s.seller_city,
       s.seller_state,
       ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
INNER JOIN sellers AS s
        ON oi.seller_id = s.seller_id
GROUP BY seller_id, seller_city, seller_state
ORDER BY total_revenue DESC
LIMIT 10;


-- QUERY 20 | Which Brazilian states generate the highest product revenue for Olist?
SELECT c.customer_state,
       ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
INNER JOIN customers c
        ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
        ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;


-- QUERY 21 | How much does a customer spend on average per order? (AOV)
SELECT ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT order_id,
           SUM(price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS order_revenue;


-- QUERY 22 | Which payment methods account for the highest total payment value on Olist?
SELECT payment_type,
       ROUND(SUM(payment_value), 2) AS total_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- QUERY 23 | Which product categories receive the highest average customer ratings?
SELECT p.product_category_name,
       ROUND(AVG(r.review_score), 2) AS average_rating,
       COUNT(*) AS total_reviews
FROM order_reviews AS r
INNER JOIN order_items AS oi
        ON r.order_id = oi.order_id
INNER JOIN products AS p
        ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING COUNT(*) >= 50
ORDER BY average_rating DESC;


-- QUERY 24 | Which product categories have the highest number of items sold on Olist?
SELECT p.product_category_name,
       COUNT(oi.order_item_id) AS total_items_sold
FROM order_items AS oi
INNER JOIN products p
        ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_items_sold DESC;


-- QUERY 25 | How many customers have placed more than one order on Olist?
SELECT customer_unique_id,
       COUNT(o.order_id) AS total_orders
FROM customers AS c
INNER JOIN orders o
        ON c.customer_id = o.customer_id
GROUP BY customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;


-- QUERY 26 | Does order status have any relationship with customer satisfaction?
SELECT o.order_status,
       ROUND(AVG(r.review_score), 2) AS average_review_score,
       COUNT(r.review_id) AS total_review
FROM orders o
INNER JOIN order_reviews AS r
        ON o.order_id = r.order_id
GROUP BY o.order_status
ORDER BY average_review_score DESC;
