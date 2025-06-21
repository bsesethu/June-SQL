--Find the products that fall within the highest 40% of the prices
SELECT * FROM Products;
SELECT *,
	   CONCAT(DistRank * 100, '%') DistRank_Perc
FROM (
SELECT 
	Product,
	Price,
	CUME_DIST() OVER(ORDER BY Price DESC) DistRank
FROM Products
)t
WHERE DistRank <= 0.4;

--Analyse the month over month performance by finding the percentage change
--in sales between the current and previous months
SELECT * FROM Orders;
SELECT
	*,
	CONCAT(ROUND(((CurrentMonthSales - PrevMonthSales) / CAST((PrevMonthSales) AS FLOAT)) * 100.0, 1), '%') Percentage_change
	--It's better to use CAST rather than multiply by 1.0. The flost value is cleaner. Formula is (f - i)/i
FROM (
	SELECT 
		MONTH(OrderDate) OrderMonth,
		SUM(Sales) CurrentMonthSales,
		LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PrevMonthSales
	FROM Orders
	GROUP BY MONTH(OrderDate)
)t;

--In order to analyse customer loyalty, rank customers based on the 
--average days between their orders
SELECT * FROM Orders


SELECT --Something's wrong in these 3 lines, Just do it SQL_guy's way
	CustomerID,
	AVG(DateDiff) AvgDays,
	RANK() OVER(PARTITION BY CustomerID ORDER BY AVG(DateDiff)) RankLoyalty
FROM (
	SELECT 
		OrderID,
		CustomerID,
		OrderDate,
		LAG(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderID) PrevOrder,
		DATEDIFF(DAY, LAG(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderID), OrderDate) DateDiff
	FROM Orders
)s--My way diverges sleightly from the desired result
)s
--GROUP BY CustomerID; 

--From SQL Guy
SELECT
	CustomerID,
	AVG(DaysUntilNext) AvgDays,
	Rank() OVER(ORDER BY COALESCE(AVG(DaysUntilNext), 9999999)) RankAvg
FROM (
	SELECT 
		OrderID,
		CustomerID,
		OrderDate CurrentOrder, --Why both. If we use one, it works the same
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
		DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNext
	FROM Orders
)t
GROUP BY CustomerID
