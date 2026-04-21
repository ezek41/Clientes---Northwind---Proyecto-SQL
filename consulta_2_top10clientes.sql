SELECT TOP 10
    c.CustomerID,
    c.CompanyName,
    COUNT(o.OrderID) AS CantidadDeOrdenes,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Montodeventasentotal,
    AVG(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS valordeordenpromedio
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY Montodeventasentotal DESC;