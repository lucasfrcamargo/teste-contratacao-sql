--Crie uma procedure que retorne cada produto e seu preço;
--Adicione à procedure, criada na questão anterior, os parâmetros 'Codigo_Fornecedor' (permitindo escolher 1 ou mais) e 'Codigo_Categoria' (permitindo escolher 1 ou mais) e altere-a para atender a passagem desses parâmetros;
--Adicione à procedure, criada na questão anterior, o parâmetro 'Codigo_Transportadora' (permitindo escolher 1 ou mais) e um outro parâmetro 'Tipo_Saida' para se optar por uma saída OLTP (Transacional) ou OLAP (Pivot).

--EXEC sp_ProductPrice '1','1,2,6,8','1,3','OLAP'
--SELECT * FROM PRODUCTS 

ALTER PROCEDURE sp_ProductPrice (@Codigo_Fornecedor NVARCHAR(MAX), @Codigo_Categoria NVARCHAR(MAX), @Codigo_Transportadora NVARCHAR(MAX), @Tipo_Saida CHAR(4))
AS
BEGIN
	SET NOCOUNT ON;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------- FAZ A DIVISÃO E VALIDAÇÃO DOS VALORES RECEBIDOS NOS PARAMETROS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF @Codigo_Fornecedor IS NULL OR TRIM(@Codigo_Fornecedor) = '' BEGIN PRINT 'Código do fornecedor esta vazio' RETURN END
IF @Codigo_Categoria IS NULL OR TRIM(@Codigo_Categoria) = '' BEGIN PRINT 'Código da categoria esta vazio' RETURN END
IF @Codigo_Transportadora IS NULL OR TRIM(@Codigo_Transportadora) = '' BEGIN PRINT 'Código da transportadora esta vazio' RETURN END
IF @Tipo_Saida NOT IN ('OLTP','OLAP') BEGIN PRINT 'Tipo de saída inválida' RETURN END

CREATE TABLE #CODFORNECEDOR (CodFornecedor NVARCHAR(10))

INSERT INTO #CODFORNECEDOR
SELECT [value]
FROM OPENJSON('["' + REPLACE(@Codigo_Fornecedor, ',', '","') + '"]')

CREATE TABLE #CODCATEGORIA (CodCategoria NVARCHAR(10))

INSERT INTO #CODCATEGORIA
SELECT [value]
FROM OPENJSON('["' + REPLACE(@Codigo_Categoria, ',', '","') + '"]')

CREATE TABLE #CODTRANSPORTADORA (CodTransportadora NVARCHAR(10))

INSERT INTO #CODTRANSPORTADORA
SELECT [value]
FROM OPENJSON('["' + REPLACE(@Codigo_Transportadora, ',', '","') + '"]')


IF EXISTS (SELECT NULL FROM #CODFORNECEDOR WHERE TRY_CONVERT(INT, CodFornecedor) IS NULL)
BEGIN
    PRINT 'Código do fornecedor está em formato incorreto'
	RETURN 
END

IF EXISTS (SELECT NULL FROM #CODCATEGORIA WHERE TRY_CONVERT(INT, CodCategoria) IS NULL)
BEGIN
	PRINT 'Código da categoria está em formato incorreto'
    RETURN 
END


IF EXISTS (SELECT NULL FROM #CODTRANSPORTADORA WHERE TRY_CONVERT(INT, CodTransportadora) IS NULL)
BEGIN
	PRINT 'Código da transportadora está em formato incorreto'
    RETURN 
END;


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------- RETORNA OS VALORES
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF @Tipo_Saida = 'OLTP'
BEGIN

WITH COD_FORNECEDOR AS (SELECT CONVERT(INT,CodFornecedor) AS CodFornecedor FROM #CODFORNECEDOR ),
	 COD_CATEGORIA AS (SELECT CONVERT(INT,CodCategoria) AS CodCategoria  FROM #CODCATEGORIA ),
	 COD_TRANSPORTADORA AS (SELECT CONVERT(INT,CodTransportadora) AS CodTransportadora FROM #CODTRANSPORTADORA )
SELECT     O.OrderID AS [Order ID]
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
WHERE P.SupplierID IN (SELECT CodFornecedor FROM COD_FORNECEDOR)
AND P.CategoryID IN (SELECT CodCategoria FROM COD_CATEGORIA)
AND S.ShipperID IN (SELECT CodTransportadora FROM COD_TRANSPORTADORA)
ORDER BY O.OrderID DESC, S.CompanyName, P.ProductName

END
ELSE
BEGIN




WITH COD_FORNECEDOR AS (SELECT CONVERT(INT,CodFornecedor) AS CodFornecedor FROM #CODFORNECEDOR ),
	 COD_CATEGORIA AS (SELECT CONVERT(INT,CodCategoria) AS CodCategoria  FROM #CODCATEGORIA ),
	 COD_TRANSPORTADORA AS (SELECT CONVERT(INT,CodTransportadora) AS CodTransportadora FROM #CODTRANSPORTADORA )
SELECT DISTINCT  P.ProductID AS [Product ID] 
		,P.ProductName AS [Product Name]
		,S.CompanyName AS [Shipping Company Name]
		,COUNT(O.OrderID) AS [Qty Order]
		,ROUND(SUM((OD.UnitPrice - (OD.UnitPrice * OD.Discount)) * OD.Quantity),2) AS [Total Sales]
		,ROUND(AVG(OD.UnitPrice),2) AS [Average Unit Price]
		,ROUND(AVG(OD.UnitPrice - (OD.UnitPrice * OD.Discount)),2) AS [Average Unit Price with Discount]
		,MAX(OD.Discount) AS [Biggest Discount]
FROM Products P
INNER JOIN Suppliers SP ON SP.SupplierID = P.SupplierID
INNER JOIN Categories C ON C.CategoryID = P.CategoryID
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
INNER JOIN Orders O ON O.OrderID = OD.OrderID
INNER JOIN Shippers S ON S.ShipperID = O.ShipVia
WHERE P.SupplierID IN (SELECT CodFornecedor FROM COD_FORNECEDOR)
AND P.CategoryID IN (SELECT CodCategoria FROM COD_CATEGORIA)
AND S.ShipperID IN (SELECT CodTransportadora FROM COD_TRANSPORTADORA)
GROUP BY P.ProductID
	,P.ProductName
	,S.CompanyName

END

END
GO

