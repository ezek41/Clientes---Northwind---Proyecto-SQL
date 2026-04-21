SELECT TOP 15
    c.Country,
    c.CompanyName,
    COUNT(o.OrderID) AS TotalPedidosEnviados,
    -- días de procesamiento (compra vs envío)
    AVG(DATEDIFF(DAY, o.OrderDate, o.ShippedDate)) AS PromedioDiasProcesamiento,
    -- peores casos
    MAX(DATEDIFF(DAY, o.OrderDate, o.ShippedDate)) AS MaximoDiasProcesamiento,
    -- Facturación total para este ranking
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS ventastotales
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.ShippedDate IS NOT NULL -- Solo pedidos con fecha de envío
  AND o.ShippedDate >= o.OrderDate -- Limpieza de fechas incoherentes
GROUP BY c.Country, c.CompanyName
ORDER BY ventastotales DESC; -- Ranking basado en monto de compras