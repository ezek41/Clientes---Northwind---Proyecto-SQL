SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    ShippedDate,
    DATEDIFF(DAY, OrderDate, ShippedDate) AS DiasDeProcesamiento
FROM Orders
-- Filtro de limpieza:
WHERE ShippedDate IS NOT NULL 
  AND ShippedDate >= OrderDate;