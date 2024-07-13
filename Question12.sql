--Crie uma query que obtenha todos os dados de pedidos (Orders) que envolvam os fornecedores da cidade 'Manchester' e foram enviados pela empresa 'Speedy Express';


SELECT O.[OrderID]					  AS [Order ID]      
      ,O.[CustomerID]				  AS [Customer ID]
	  ,C.CompanyName				  AS [Customer Name]
      ,O.[EmployeeID]				  AS [Employee ID]
	  ,E.FirstName + ' ' + E.LastName AS [Employee Name]
      ,O.[OrderDate]				  AS [Order Date]	
      ,O.[RequiredDate]				  AS [Required Date]	
      ,O.[ShippedDate]				  AS [Shipped Date]	
      ,O.[ShipVia]					  AS [Ship Via]		
	  ,SP.CompanyName				  AS [Shipping Company Name]
      ,O.[Freight]					  AS [Freight]			
      ,O.[ShipName]					  AS [Ship Name]			
      ,O.[ShipAddress]				  AS [Ship Address]		
      ,O.[ShipCity]					  AS [Ship City]			
      ,O.[ShipRegion]				  AS [Ship Region]		
      ,O.[ShipPostalCode]			  AS [Ship Postal Code]	
      ,O.[ShipCountry]				  AS [Ship Country]		
      ,P.[ProductID]				  AS [Product ID]		
	  ,P.ProductName				  AS [Product Name]		
      ,OD.[UnitPrice]				  AS [Unit Price]	
      ,OD.[Quantity]				  AS [Quantity]	
      ,OD.[Discount]				  AS [Discount]	
	  ,S.CompanyName				  AS [Supplies Company Name]	
	  ,S.City						  AS [City]			
  FROM Suppliers S
INNER JOIN Products P ON P.SupplierID = S.SupplierID
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
INNER JOIN Orders O ON O.OrderID = OD.OrderID
INNER JOIN Shippers SP ON SP.ShipperID = O.ShipVia
INNER JOIN Customers C ON C.CustomerID = O.CustomerID
INNER JOIN Employees E ON E.EmployeeID = O.EmployeeID
WHERE SP.CompanyName = 'Speedy Express'
AND S.City = 'Manchester'
