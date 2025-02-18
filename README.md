# Exploratory-Data-Analysis-EDA-

Via Measure and Dimension

In this project, I used some basic commands to review the dataset and gain a clear understanding of the data.

Here are the basic queries I used in the EDA.

# Data Profiling to explore the database.

Using the INFORMATION_SCHEMA.TABLES function to review the available tables and INFORMATION_SCHEMA.COLUMNS to explore the number of columns in a specific table.

 # Simple Aggregations.

Using aggregation functions like MIN and MAX to determine the dates of the first and last orders, and applying the DATEDIFF function to calculate the number of years between them.

Functions such as SUM, AVERAGE, COUNT, and COUNT(DISTINCT) were used to provide more insights into total sales, the number of orders, and average price. By combining all these metrics with UNION ALL, I generated a comprehensive report that highlights key business metrics in a simple and clear format.

# Magnitude Analysis.

By grouping dimensions using the GROUP BY function, I was able to get an overview of total sales by country, gender, and category. This provided valuable insights, such as identifying the country with the most orders, the gender we are targeting the most, and the best-selling products.

# Ranking Analysis.

I performed ranking analysis to identify the top 5 products with the highest revenue by using the TOP function and sorting the total revenue in descending (DESC) order to ensure the highest revenue appears first.

I also conducted a similar analysis to identify the three customers with the fewest orders. This was done by sorting the order count in ascending (ASC) order and applying TOP 3 to review the results.

 # Subquery.

I used subqueries to add a ranking with the ROW_NUMBER function, which can be filtered using the WHERE clause for more targeted analysis when performing research.

 

- 
- Simple Aggregations
- Subquery
