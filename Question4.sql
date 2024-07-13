--Crie uma query que obtenha a lista de produtos (ProductID, ProductName, UnitPrice) ativos, onde o custo dos produtos são menores que $20;

SELECT ProductID
	  ,ProductName
	  ,UnitPrice
FROM Products
WHERE Discontinued = 0
AND UnitPrice < 20
