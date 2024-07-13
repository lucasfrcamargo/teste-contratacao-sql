--Crie uma query que obtenha a lista de empregados e seus liderados, caso o empregado n�o possua liderado, informar 'N�o possui liderados'

SELECT E.[EmployeeID] AS [ID Empregado] 
      ,E.[LastName] AS [Nome]
      ,E.[FirstName] AS [Sobrenome]
      ,ISNULL(STUFF((SELECT ', ' + CONCAT(R.FirstName, ' ', R.LastName)
                      FROM Employees R
                      WHERE R.ReportsTo = E.EmployeeID
                      FOR XML PATH('')), 1, 2, ''), 'N�o possui liderados') AS Liderados
FROM [Target.TesteDB].[dbo].[Employees] E
GROUP BY E.EmployeeID, E.LastName, E.FirstName
