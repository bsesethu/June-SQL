--Identify duplicate rows in the tsble 'Orders_Archive'
--And return the clean result without any duplicates
SELECT * FROM OrdersArchive;

SELECT *
FROM (
	SELECT
		ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY OrderID) RankOrderID,
		*
	FROM OrdersArchive
)t
WHERE RankOrderID = 1
--I've already done this actually

--Using CHARINDEX and CUME_DIST
SELECT 
	OrderID,
	CustomerID,
	Sales,
	CHARINDEX('M', ShipAddress) M_Position,
	CUME_DIST() OVER(PARTITION BY CustomerID ORDER BY Sales) CumeSales
--	NTILE(4) OVER(PARTITION BY CustomerID ORDER BY Sales) Quartile --I don't think this is how to use it
FROM OrdersArchive;

