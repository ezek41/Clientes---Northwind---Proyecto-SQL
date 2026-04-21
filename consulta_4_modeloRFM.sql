WITH modelorfm AS (
    SELECT 
        o.CustomerID,
        DATEDIFF(day, MAX(o.OrderDate), (SELECT MAX(OrderDate) FROM Orders)) AS Recency,
        COUNT(DISTINCT o.OrderID) AS Frequency, 
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Monetary
    FROM Orders o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
),
TotalVentasGlobal AS (
    -- Calculamos el total de todas las ventas una sola vez
    SELECT SUM(Monetary) AS GranTotal FROM modelorfm
),
RankingMonetario AS (
    SELECT 
        b.*,
        PERCENT_RANK() OVER (ORDER BY b.Monetary) AS PercentilCalculo,
        (b.Monetary / (SELECT GranTotal FROM TotalVentasGlobal)) * 100 AS PorcentajeVentas
    FROM modelorfm b
),
calculoauxiliar AS (
    SELECT 
        AVG(CAST(Frequency AS FLOAT)) as AvgFreq,
        AVG(CAST(Recency AS FLOAT)) as AvgRec
    FROM RankingMonetario
    WHERE PercentilCalculo >= 0.8
)
SELECT 
    b.CustomerID,
    b.Recency,
    b.Frequency,
    b.Monetary,
    CAST(b.PorcentajeVentas AS DECIMAL(10,2)) AS [%_Representa_Ventas],
    CASE 
        WHEN b.Recency > (SELECT AvgRec FROM calculoauxiliar) AND b.Frequency > (SELECT AvgFreq FROM calculoauxiliar) 
            THEN 'cliente en Fuga Potencial'
        WHEN b.Recency > (SELECT AvgRec * 1.5 FROM calculoauxiliar) 
            THEN 'cliente Perdido'
        ELSE 'cliente Activo'
    END AS Estatus_Fuga
FROM RankingMonetario b
WHERE b.PercentilCalculo >= 0.8 -- Seguimos filtrando el Top 20%
ORDER BY b.Monetary DESC;