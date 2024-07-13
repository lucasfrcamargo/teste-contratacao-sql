--Crie uma query que obtenha a lista de Produtos (ProductName) constantes nos Detalhe dos Pedidos (Order Details)
--, calculando o valor total de cada produto já aplicado o desconto % (se tiver algum);

SELECT OD.[OrderID]    AS [Order ID]
      ,OD.[ProductID]  AS [Product ID]
	  ,P.ProductName   AS [Product Name]
      ,OD.[UnitPrice]  AS [Unit Price]
      ,OD.[Quantity]   AS [Quantity]
      ,OD.[Discount]   AS [Discount]
	  ,ROUND((OD.UnitPrice - (OD.UnitPrice * OD.Discount)) * OD.Quantity,2) AS [Total Value]
FROM Products P
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
