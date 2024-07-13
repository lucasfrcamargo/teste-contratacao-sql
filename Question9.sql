--Crie uma query que obtenha o(s) produto(s) mais caro(s) e o(s) mais barato(s) da lista (ProductName e UnitPrice);

WITH TOPMOST AS (SELECT TOP 5
			   [TOP] = 'Top ' + CAST(ROW_NUMBER() OVER (ORDER BY UnitPrice DESC) AS CHAR(1)) + ' Most Expensive'
			   ,ProductID
			   ,ProductName
			   ,UnitPrice
				FROM Products
				ORDER BY UnitPrice DESC),
TOPCHEAPER AS (SELECT TOP 5
			  [TOP] = 'Top ' + CAST(ROW_NUMBER() OVER (ORDER BY UnitPrice ) AS CHAR(1)) + ' Cheaper'
			 ,ProductID
			 ,ProductName
			 ,UnitPrice
			FROM Products
			ORDER BY UnitPrice )
SELECT * FROM TOPMOST 
UNION ALL
SELECT * FROM TOPCHEAPER
