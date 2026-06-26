show databases;

use pizza_db;

select * from pizza_sales;

-- Total Revenue calculate :

SELECT 
    ROUND(SUM(total_price), 0) AS Total_Revenue
FROM
    pizza_sales;
    
    
-- Calculate average Ordered Value :Average amount spend per order,calculated by dividing  the total revenue by the total num of orders--


SELECT 
   round(SUM(total_price) / COUNT(DISTINCT (order_id)),0) AS Avg_Amount
FROM
    pizza_sales;
    
-- Total Pizza Sold : sum of quantity of pizza sold 

SELECT 
    SUM(quantity) AS Total_Sale
FROM
    pizza_sales;
    
-- Total Orders Placed : 

SELECT 
    COUNT(DISTINCT (order_id)) AS Total_Orders
FROM
    pizza_sales;
    
-- Average pizzas per order :

SELECT 
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10,2)) /
        CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
        AS DECIMAL(10,2)
    ) AS avg_pizzas_per_order
FROM pizza_sales;
    
-- Chart Calculations : 

-- 1) Daily Trend for Total Orders :

SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Order_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM
    pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));


-- Monthly Trend for total orders :  

SELECT 
    MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM
    pizza_sales
GROUP BY MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) order by total_orders Desc;


-- 3 Percentage of sales by pizza category :
-- for pie chart 

SELECT 
    pizza_category,
    ROUND(SUM(total_price), 2) AS Total_Sale,
    ROUND(
        SUM(total_price) * 100 /
        (SELECT SUM(total_price)
         FROM pizza_sales
         WHERE MONTH(STR_TO_DATE(order_date,'%d-%m-%Y')) = 1),
        2
    ) AS pct_sales
FROM pizza_sales
WHERE MONTH(STR_TO_DATE(order_date,'%d-%m-%Y')) = 1
GROUP BY pizza_category;

-- Problem Statment : Chart Requriments
-- Percentage of sales by pizza size

SELECT 
    pizza_size,
    ROUND(SUM(total_price), 0) AS Total_Sales,
    ROUND(
        SUM(total_price) * 100 /
        (
            SELECT SUM(total_price)
            FROM pizza_sales
            WHERE QUARTER(STR_TO_DATE(order_date,'%d-%m-%Y')) = 1
        ),
        2
    ) AS PCT
FROM pizza_sales
WHERE QUARTER(STR_TO_DATE(order_date,'%d-%m-%Y')) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

-- Top 5 & Bottom  best sellers by Revenue,Total Quantity & Total Orders : when u are using any aggrigation in queryalways use group by

SELECT 
    pizza_name, round(SUM(total_price) ,0) AS Best_sell_Pizza
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Best_sell_Pizza DESC limit 5;

-- Bottom 5 Pizza :

SELECT 
    pizza_name, round(SUM(total_price) ,0) AS Best_sell_Pizza
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Best_sell_Pizza ASC limit 5;






 



