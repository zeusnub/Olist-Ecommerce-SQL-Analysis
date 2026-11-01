#query 17-retrieve orders with customer information 
select o.order_id,o.customer_id,o.order_status,c.customer_city,c.customer_state
from orders as o
inner join customers as c 
on o.customer_id=c.customer_id
limit 20;

#query 18-Which product categories generate the highest revenue for Olist?
select p.product_category_name,round(sum(oi.price),2) as total_revenew
from order_items as oi
inner join products as p
on oi.product_id=p.product_id
group by product_category_name
order by total_revenew desc;

#query 19-Which 10 sellers generate the highest revenue for Olist?
select s.seller_id,s.seller_city,s.seller_state,
round(sum(oi.price),2) as total_revenew
from order_items as oi
inner join sellers as s 
on oi.seller_id=s.seller_id
group by seller_id,seller_city,seller_state
order by total_revenew desc
limit 10;

#query 20-Which Brazilian states generate the highest product revenue for Olist?
select c.customer_state,round(sum(oi.price),2) as total_revenew
from orders o
inner join customers c
on c.customer_id=o.customer_id
inner join order_items as oi
on o.order_id=oi.order_id
group by c.customer_state
order by total_revenew desc;

#query 21-How much does a customer spend on average per order?(AOV)
SELECT round(avg(order_total),2) as average_order_value
from(
select order_id,sum(price) as order_total
from order_items
group by order_id
) as order_revenew

#query 22-Which payment methods account for the highest total payment value on Olist?
select payment_type,round(sum(payment_value),2) as total_payment_value
from order_payments 
group by payment_type
order by total_payment_value desc;

#query 23-Which product categories receive the highest average customer ratings?
select p.product_category_name, round(avg(r.review_score),2) as average_rating,
count(*) as total_reviews
from order_reviews as r
inner join order_items as oi
on r.order_id=oi.order_id
inner join products as p
on oi.product_id=p.product_id
group by p.product_category_name
having count(*)>=50
order by average_rating desc;

#query 24-Which product categories have the highest number of items sold on Olist? 
select p.product_category_name,count(oi.order_item_id) as total_items_sold
from order_items as oi
inner join products p
on oi.product_id=p.product_id
group by p.product_category_name
order by total_items_sold desc;

#query 25- how many customers have placed more than one order on olist?
select customer_unique_id,count(o.order_id) as total_orders
from customers as c
inner join orders o 
on c.customer_id=o.customer_id
group by customer_unique_id
having count(o.order_id)>1
order by total_orders desc;

#query 26-Does order status have any relationship with customer satisfaction?
select o.order_status,round(avg(r.review_score),2) as average_review_score,
count(r.review_id) as total_review
from orders o
inner join order_reviews as r
on o.order_id=r.order_id
group by o.order_status
order by average_review_score desc;




