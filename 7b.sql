WITH Orders_CTE(OrderID, CustomerID)
AS (
	SELECT OrderID, CustomerID FROM [dbo].[Order]
	WHERE [OrderDate] >= DATEADD(MONTH, -6, GETDATE())
)
SELECT cust.CustID, cust.FirstName, cust.LastName,
CASE 
	WHEN SUM(Cost) IS NOT NULL THEN SUM(Cost)
	ELSE 0
END
FROM [dbo].[Customer] as cust
LEFT JOIN Orders_CTE as ord ON cust.CustID = ord.CustomerID
LEFT JOIN [dbo].[OrderLine] as line ON ord.OrderID = line.OrdID
GROUP BY cust.CustID, cust.FirstName, cust.LastName