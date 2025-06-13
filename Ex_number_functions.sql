SELECT OrderID, 
	   Quantity, 
	   Sales

FROM Orders;

SELECT sum(Quantity) sum_quantity,
	   avg(Sales) average_sales
	   
FROM Orders