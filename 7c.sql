WITH Orders_CTE(OrderID, CustomerID)
AS (
	SELECT OrderID, CustomerID FROM [dbo].[Order]
	WHERE [OrderDate] >= DATEADD(MONTH, -6, GETDATE())
)
SELECT cust.CustID, cust.FirstName, cust.LastName, SUM(Cost)
FROM [dbo].[Customer] as cust
INNER JOIN Orders_CTE as ord ON cust.CustID = ord.CustomerID
LEFT JOIN [dbo].[OrderLine] as line ON ord.OrderID = line.OrdID
GROUP BY cust.CustID, cust.FirstName, cust.LastName
HAVING SUM(Cost) > 100 AND SUM(Cost) < 500