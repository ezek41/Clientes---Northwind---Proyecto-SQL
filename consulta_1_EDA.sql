SELECT 
    COUNT(DISTINCT o.CustomerID) AS TotalClientes,
    COUNT(DISTINCT o.OrderID) AS TotalPedidos,
    -- Financiero
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS VentasNetas,
    ROUND(SUM(od.UnitPrice * od.Quantity * od.Discount), 2) AS TotalDescuentoenDolares,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) / COUNT(DISTINCT o.OrderID), 2) AS ValorTicketPromedio,
    -- Logística
    COUNT(DISTINCT o.ShipCountry) AS PaisesAlcanzados,
    AVG(CAST(od.Quantity AS FLOAT)) AS PromedioUnidadesPorOrden,
    COUNT(DISTINCT od.ProductID) AS SKUsVendidos
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID;