--Crie uma query que obtenha a lista de produtos ativos (ProductID e ProductName);

SELECT ProductID
      ,ProductName
FROM Products
WHERE Discontinued = 0
