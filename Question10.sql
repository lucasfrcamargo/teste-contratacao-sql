--Crie uma query que obtenha a lista de pedidos dos funcionários da região 'Western';


WITH EMPLOYEES_WESTERN AS ( SELECT DISTINCT E.EmployeeID AS ID
							FROM Employees E
							INNER JOIN EmployeeTerritories ET ON ET.EmployeeID = E.EmployeeID
							INNER JOIN Territories T ON T.TerritoryID = ET.TerritoryID
							INNER JOIN Region R ON R.RegionID = T.RegionID
							WHERE R.RegionDescription = 'Western'
)
SELECT O.OrderID AS [Order ID]
	  ,S.CompanyName AS [Shipping Company Name]
      ,P.ProductID AS [Product ID] 
	  ,P.ProductName AS [Product Name]
	  ,S.CompanyName AS [Supplier Name]
	  ,C.CategoryName AS [Category Name]
	  ,OD.UnitPrice AS [Unit Price]
	  ,OD.Quantity AS [Quantity]
	  ,OD.Discount AS [Discount]
FROM Products P
INNER JOIN Suppliers SP ON SP.SupplierID = P.SupplierID
INNER JOIN Categories C ON C.CategoryID = P.CategoryID
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
INNER JOIN Orders O ON O.OrderID = OD.OrderID
INNER JOIN Shippers S ON S.ShipperID = O.ShipVia
WHERE O.EmployeeID IN (SELECT ID FROM EMPLOYEES_WESTERN)
ORDER BY O.OrderID DESC, S.CompanyName, P.ProductName

