--Crie uma query que obtenha a lista de produtos (ProductID, ProductName, UnitPrice) ativos, onde o custo dos produtos são entre $15 e $25;

SELECT ProductID
      ,ProductName
      ,UnitPrice
FROM Products
WHERE Discontinued = 0
AND UnitPrice BETWEEN 15 AND 25
