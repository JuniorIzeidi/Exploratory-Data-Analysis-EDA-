-- Explore All Objects in the Database
Select * from INFORMATION_SCHEMA.TABLES

--Explore All columns in the dataset
Select * from INFORMATION_SCHEMA.COLUMNS
Where TABLE_NAME = 'dim_customers'

--Dimension Exploration 

-- Explore All countries our customers is coming from.

Select distinct (country)
From gold.dim_customers

-- Explore All categories "The major Divisions".

Select distinct category, subcategory,product_name
From gold.dim_products
order by 1,2,3


-- Date Exploration.

-- Find the date of the first and last order 
-- How many years of sales are available

Select 
	MIN(order_date) as First_order,
	Max(Order_date) as Last_order, 
	DATEDIFF(year,MIN(order_date),Max(Order_date)) as Years_difference
from gold.fact_sales

-- Find the youngest and oldest customer

Select 
		Min(birthdate) as Oldest_birthdate, 
		DATEDIFF(YEAR,Min(birthdate), getdate()) as Oldest_Age, 
		DATEDIFF(Year,Max(birthdate), getdate ()) as Youngest_Age,
		Max(birthdate) as Youngest_birthdate
from gold.dim_customers

-- Measure Exploration

-- Find the total Sales

Select 
	Sum(sales_amount) as Total_sales
from gold.fact_sales

-- Find how Many items were sold

Select
	sum(quantity) as Item_Sold
from gold.fact_sales

-- Find the average Selling price

Select
	AVG(price) as Avg_Price
from gold.fact_sales

-- Find the total number of orders

Select
	Count(order_number) as Total_orders,
	count(distinct order_number) as Total_distinct_orders
from gold.fact_sales

-- Find the total number of products

Select 
	COUNT(product_key) as Total_products
From gold.dim_products

-- Find the total number of customers

Select 
	count(customer_id) as Total_customer,
	count(distinct customer_id) as Total_distinct_customer
from gold.dim_customers

-- Find the total number of customers that has placed an order

Select 
		COUNT(customer_key) as Total_order_by_customer,
		COUNT(distinct customer_key) as Total_Distinct_order_by_customer
from gold.fact_sales


-- Generate a report that shows all key metrics of the business

Select 'Total Sales' as Measure_Name, Sum(sales_amount)as Measure_Value from gold.fact_sales
Union All
Select 'Total Quantity' as Measure_Name, Sum(quantity)as Measure_Value from gold.fact_sales
Union All
Select 'Average Price' as Measure_Name, AVG(price) as Measure_Value from gold.fact_sales
Union All
Select 'Total number of Orders' as Measure_Name, count(distinct order_number) Measure_Value from gold.fact_sales
Union All
Select 'Total number of Products' as Measure_Name, count(distinct product_key) Measure_Value from gold.fact_sales
Union All
Select 'Total number of Customers' as Measure_Name, count(distinct customer_key) Measure_Value from gold.dim_customers
Union All
Select 'Total number of Customers passed order' as Measure_Name, count(distinct customer_key) Measure_Value from gold.fact_sales


-- Magnitude Analysis

-- Find the total sales per Countries

Select country, count(customer_key) as total_sales from gold.dim_customers group by country order by total_sales Desc

-- Find the total customers by gender

Select gender, count(customer_key) as total_sales from gold.dim_customers group by gender order by total_sales Desc

-- Find the total product per category 

Select category , count(product_key) as Total_product from gold.dim_products group by category order by Total_product desc	

-- What is the average costs in each category

Select category , avg(cost) as Average_Cost from gold.dim_products group by category order by Average_Cost desc	
 

-- What is the total revenue generated for each category

Select 
	p.category,
	sum(sales_amount) as Total_revenue
From gold.fact_sales as f
left join gold.dim_products p
on p.product_key = f.product_key
group by p.category
order by Total_revenue Desc

-- Find total revenue is generated by each customer 

Select 
	c.customer_id,
sum(sales_amount) as Total_revenue
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
group by c.customer_id
order by Total_revenue desc 


--What is the distribution of Sold items across countries

Select 
	c.country,
sum(quantity) as Total_quantity
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
group by c.country
order by Total_quantity desc 

-- Ranking Analysis

-- Which 5 products generated the highest revenue 

Select top 5
	P.product_name,
	Sum(S.sales_amount) as Total_Revenue
From gold.fact_sales S
Left join gold.dim_products P
on S.product_key = P.product_key
group by P.product_name
order by Total_Revenue Desc


Select * 
from(
Select 
	P.product_name,
	Sum(S.sales_amount) as Total_Revenue,
	ROW_NUMBER() over (order by Sum(S.sales_amount) desc) as Ranking
From gold.fact_sales S
Left join gold.dim_products P
on S.product_key = P.product_key
group by P.product_name
) A Where Ranking<=5


--What are the 5 worst-performing products in terms od sales

Select top 5
	P.product_name,
	Sum(S.sales_amount) as Total_Revenue
From gold.fact_sales S
Left join gold.dim_products P
on S.product_key = P.product_key
group by P.product_name
order by Total_Revenue ASC

-- Find the top 10 customers who have generated the highest revenue

Select Top 10
		C.customer_key,
		C.first_name,
		c.last_name,
		Sum(s.sales_amount) as Total_Revenue
From gold.fact_sales S
Left join gold.dim_customers C
on S.customer_key = C.customer_key
group by C.customer_key,
C.first_name,
c.last_name
order by Total_Revenue Desc

-- The 3 customers with the fewest orders placed

Select Top 3
		C.customer_key,
		C.first_name,
		c.last_name,
		Count(distinct order_number) as orders
From gold.fact_sales S
Left join gold.dim_customers C
on S.customer_key = C.customer_key
group by C.customer_key,
C.first_name,
c.last_name
order by orders asc