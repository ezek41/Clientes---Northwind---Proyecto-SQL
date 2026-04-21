SELECT TOP 10
    c.Country,
    COUNT(DISTINCT o.OrderID) AS TotalPedidos,
    AVG(DATEDIFF(DAY, o.OrderDate, o.ShippedDate)) AS PromedioDiasProcesamiento,
    MIN(DATEDIFF(DAY, o.OrderDate, o.ShippedDate)) AS MinimoDias,
    MAX(DATEDIFF(DAY, o.OrderDate, o.ShippedDate)) AS MaximoDias,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS ventastotales
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.ShippedDate IS NOT NULL 
  AND o.ShippedDate >= o.OrderDate
GROUP BY c.Country
ORDER BY ventastotales DESC;