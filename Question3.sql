--Crie uma query que obtenha a lista de produtos descontinuados (ProductID e ProductName);

SELECT ProductID
      ,ProductName
FROM Products
WHERE Discontinued = 1

