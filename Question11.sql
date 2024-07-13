--Crie uma query que obtenha os números de pedidos e a lista de clientes (CompanyName, ContactName, Address e Phone)
--, que possuam 171 como código de área do telefone e que o frete dos pedidos custem entre $6.00 e $13.00;
WITH CUSTOMERS_171 AS ( SELECT DISTINCT CustomerID AS ID
							FROM Customers
							WHERE LEFT(Phone,5) = '(171)' -- LEFT é mais rapido que usar LIKE
)
SELECT O.OrderID AS [Order ID]
	  ,CM.CompanyName AS [Company Name]
	  ,CM.ContactName AS [Contact Name]
	  ,CM.Address AS [Address]
	  ,CM.Phone AS [Phone]
	  ,S.CompanyName AS [Shipping Company Name]
      ,P.ProductID AS [Product ID] 
	  ,P.ProductName AS [Product Name]
	  ,S.CompanyName AS [Supplier Name]
	  ,C.CategoryName AS [Category Name]
	  ,OD.UnitPrice AS [Unit Price]
	  ,OD.Quantity AS [Quantity]
	  ,OD.Discount AS [Discount]
	  ,O.Freight AS [Freight]
FROM Products P
INNER JOIN Suppliers SP ON SP.SupplierID = P.SupplierID
INNER JOIN Categories C ON C.CategoryID = P.CategoryID
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
INNER JOIN Orders O ON O.OrderID = OD.OrderID
INNER JOIN Shippers S ON S.ShipperID = O.ShipVia
INNER JOIN Customers CM ON CM.CustomerID = O.CustomerID 
WHERE CM.CustomerID IN (SELECT ID FROM CUSTOMERS_171)
AND O.Freight BETWEEN 6 AND 13
ORDER BY O.OrderID DESC, S.CompanyName, P.ProductName