#query 9-how many orders belong to each order status?
select order_status,count(*) as total_orders
from orders
group by order_status 
order by count(*) desc;

#query 10-What is the average value of a payment recorded in the Olist dataset?
SELECT
    ROUND(AVG(payment_value), 2) AS average_payment
FROM order_payments;

#query 11-What is the total value of all payments recorded in the dataset?
select round(sum(payment_value),2) as total_payments
from order_payments; 

#query 12- Which payment methods are used most frequently by customers?
select payment_type,count(*) as total_transactions
from order_payments
group by payment_type
order by count(*) desc;

#query 13-Which Brazilian states have the highest number of customers?
select customer_state,count(*) as total_customers
from customers
group by customer_state
order by count(*) desc;

#query 14-How many products belong to each product category?
select product_category_name,count(*) as total_products
from products 
group by product_category_name
order by count(*) desc;

#query 15-Which sellers have sold more than 50 items?
select seller_id,count(*) as total_items_sold
from order_items
group by seller_id
having count(*)>50
order by count(*) desc;

#query 16-How many customer reviews does each rating (1–5 stars) receive?
select review_score,count(*) as total_reviews
from order_reviews
group by review_score
order by total_reviews desc;

