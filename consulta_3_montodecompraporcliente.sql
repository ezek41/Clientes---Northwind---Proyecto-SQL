SELECT
    c.CustomerID,
    c.CompanyName,
    COUNT(DISTINCT o.OrderID) AS CantidadDeOrdenes,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS Montodeventasentotal,
    ROUND(AVG(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS valordeordenpromedio
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY Montodeventasentotal DESC;