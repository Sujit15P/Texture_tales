use Texture_tales


--Q1

select product_details.product_name, sum( sales.qty) as sales_count from sales inner join product_details 
on sales.prod_id=product_details.product_id
group by product_details.product_name
order by sales_count desc;

--Q2 What is the total generated revenue for all products before discounts?
-- using sales tables column Qty and price 

select sum(price*qty) as without_discount from sales;

--Q3 What was the total discount amount for all products?

select sum( price*qty*discount)/100 as total_discount from sales;


--Q4 How many unique transactions were there?
--for unique use dintinct

select count(distinct txn_id) as uni_txn from sales;

--Q5 What are the average unique products purchased in each transaction?
-- in single transaction there is more than one purchase we use CTE

with cte_tran_prod as(
select txn_id, count(distinct sales.prod_id) as uni_prod from sales
group by txn_id)
select avg( uni_prod) as avg_uni_prod from cte_tran_prod;


--Q6 What is the average discount value per transaction?

with cte_disc_txn  as(
select txn_id, sum(price*qty*discount)/100  as total_disc from sales
group by txn_id)
select avg( total_disc) as avg_disc_txn from cte_disc_txn;

--Q7 What is the average revenue for member transactions and non-member transactions?
-- member values in true/false ,revenue per tran

with cte_rev_member as (
select member, txn_id, sum( price*qty) as revenue from sales
group by member, txn_id)
select member, round(avg(revenue),2) as avg_rev from cte_rev_member
group by member;

--Q8 What are the top 3 products by total revenue before discount?

select top 3 product_details.product_name, sum(qty*sales.price) as without_discount from sales inner join product_details
on sales.prod_id=product_details.product_id
group by product_details.product_name
order by without_discount ; 


--Q9 What are the total quantity, revenue and discount for each segment?

select product_details.segment_id, product_details.segment_name , sum( sales.qty) as total_qty ,
sum( sales.qty*sales.price) as total_revenue, sum( sales.qty*sales.price*sales.discount)/100 as total_discount
from sales inner join product_details
on sales.prod_id=product_details.product_id
group by product_details.segment_id, product_details.segment_name
order by total_revenue;

--Q10 What is the top selling product for each segment?

select top 5 details.segment_id, details.segment_name, details.product_id, details.product_name,
sum( sales.qty) as prod_qty from sales inner join  product_details as details
on sales.prod_id=details.product_id
group by details.segment_name, details.segment_id, details.product_name, details.product_id;


--Q11 What are the total quantity, revenue and discount for each category?

select details.category_id, details.category_name, 
sum( sales.qty) as total_qty, sum( sales.qty*sales.price) as total_revenue, sum( sales.qty*sales.price*sales.discount)/100 as total_discount
from sales inner join  product_details as details
on sales.prod_id=details.product_id
group by details.segment_name, details.category_id, details.category_name
order by category_name;

--Q12 What is the top selling product for each category?

select top 5 details.category_id, details.category_name, details.product_id, details.product_name,
sum( sales.qty) as prod_qty from sales inner join  product_details as details
on sales.prod_id=details.product_id
group by details.category_name, details.category_id, details.product_name, details.product_id
order by prod_qty desc;


































































































































































