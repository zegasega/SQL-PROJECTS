/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
-- 2. How many days has each customer visited the restaurant?
-- 3. What was the first item from the menu purchased by each customer?
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- 5. Which item was the most popular for each customer?
-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
use case1
-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
	s.customer_id,sum(m.price) as total_spent
FROM sales as s
JOIN menu m on s.product_id = m.product_id
GROUP BY customer_id

-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(order_date) as total_visited_days FROM sales
GROUP BY customer_id

-- What was the first item from the menu purchased by each customer?
with tablo as(
SELECT 
	distinct customer_id,
    order_date,
    product_name,
    rank() over(PARTITION BY customer_id order by order_date) rn
FROM sales s
JOIN menu m on m.product_id = s.product_id)

select 
	customer_id,product_name
from tablo
where rn = 1

-- What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT 
    product_name,count(*) as total_order
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY product_name
order by total_order desc
limit 1
-- 5. Which item was the most popular for each customer?
SELECT * from sales s
JOIN menu m on m.product_id = s.product_id
Order by customer_id, order_date

SELECT
 customer_id,
 product_name,
 COUNT(s.product_id) 
from sales s
JOIN menu m on m.product_id = s.product_id
GROUP BY 1, 2

-- 6. Which item was purchased first by the customer after they became a member?
SELECT * FROM members
SELECT * FROM sales

SELECT * from sales s
join menu m on s.product_id = m.product_id
join members mem on mem.customer_id = s.customer_id
where order_date >= join_date
order by 1

-- 7. Which item was purchased just before the customer became a member?

SELECT * from sales s
join menu m on s.product_id = m.product_id
join members mem on mem.customer_id = s.customer_id
where order_date < join_date
order by 1

-- 8. What is the total items and amount spent for each member before they became a member?
SELECT s.customer_id, SUM(m.price) 
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON mem.customer_id = s.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
with tablo as(
SELECT 
	customer_id,
    product_name,
    price,
    CASE
		WHEN product_name = 'sushi' then price * 10 * 2
        ELSE price * 10
        end points
FROM sales s
join menu m on m.product_id = s.product_id)

SELECT 
	customer_id,
    SUM(points)
FROM tablo
group by 1
order by 2 desc





