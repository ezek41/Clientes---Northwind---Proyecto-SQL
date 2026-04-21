SELECT 
    'Fechas Incoherentes' AS TipoError,
    COUNT(*) AS CantidadRegistros
FROM Orders
WHERE ShippedDate < OrderDate -- El envío no puede ser antes que la compra

UNION ALL

SELECT 
    'Pedidos sin Fecha de Envío (NULL)' AS TipoError,
    COUNT(*) AS CantidadRegistros
FROM Orders
WHERE ShippedDate IS NULL;