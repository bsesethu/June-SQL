use Master
use My_vehicle_options
SELECT * FROM Sedans;

SELECT 
	car_manufacturer,
	car_make,
	engine_size,
	top_speed,
	SUM(cost) OVER() sum_noPart,
	SUM(cost) OVER(PARTITION BY top_speed) sum_Part1,
	SUM(cost) OVER(PARTITION BY top_speed, engine_size) sum_Part2
FROM Sedans;

use Master
use SQL_guy
SELECT * FROM OrdersArchive

--Check whether the table OrdersArchive contains any duplicates
SELECT *
FROM(
SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) Check_PK
FROM OrdersArchive
)t
WHERE CHeck_PK > 1;

--Find the percentage contribution of each product's sales to the total sales
SELECT * FROM Orders

SELECT 
	OrderID,
	ProductID,
	Sales, 
	SUM(Sales) OVER() Total_sales, --OVER so it doesnt return a single row column
	ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER() * 100, 2) Percent_of_total, 
	--avg sales across all orders
	AVG(Sales) OVER() AvgSales,
	--avg sales for each prduct
	AVG(Sales) OVER(PARTITION BY ProductID) AvgProd
FROM Orders;

--Calculate moving average of sales for each product over time
SELECT 
	OrderID,
	ProductID,
	Sales, 
	OrderDate,
	AVG(Sales) OVER(PARTITION BY ProductID) MovingAvgByProd,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
	--I'm not sure I quite understand what's happening here.
	--I pretty much get it, it's an interesting and usefull result
	--Including only the next order
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Orders;

--Rank the orders based on their sales from highest to lowest
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
	RANK() OVER(ORDER BY Sales DESC) SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRank_Dense
FROM Orders;

--Find highest sales from each product
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) PartSalesRank_Row
FROM Orders

--My own exercise
SELECT *
FROM (
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) PartSalesRank_Row
FROM Orders 
)t 
WHERE PartSalesRank_Row <= 2
ORDER BY PartSalesRank_Row ASC;

--Find lowest 2 customers based on their total sales
SELECT * FROM Orders;
SELECT *
FROM (
SELECT 
	CustomerID,
	SUM(Sales) SumSales,
	ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankSum
FROM Orders
GROUP BY CustomerID
)t
WHERE RankSum <= 2;

--Assign unique IDs to the rows of the OrdersArchive table
SELECT * FROM OrdersArchive;
SELECT 
	ROW_NUMBER() OVER(ORDER BY OrderID) UniqueID,
	*
FROM OrdersArchive;

--Segment all orders into 3 categorie, high, medium and low sales
SELECT * FROM Orders;
SELECT
	*,
	CASE WHEN Buckets = 1 THEN 'High'
		 WHEN Buckets = 2 THEN 'Medium'
		 WHEN Buckets = 3 THEN 'Low'
	END SalesSegments
FROM (
	SELECT	
		OrderID, 
		Sales,
		NTILE(3) OVER(ORDER BY Sales DESC) Buckets
	FROM Orders
)t
