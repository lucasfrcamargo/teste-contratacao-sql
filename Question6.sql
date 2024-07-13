--Crie uma query que obtenha a lista de produtos (ProductName, UnitPrice) que tem preço acima da média;


WITH AVERAGE AS (SELECT AVG(UnitPrice) AS AVG_UnitPrice FROM Products)
SELECT ProductName, UnitPrice
FROM Products
CROSS JOIN AVERAGE
WHERE UnitPrice > AVG_UnitPrice

