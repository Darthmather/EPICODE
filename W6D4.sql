--Req#2.1 Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria DimProduct, DimProductSubcategory)
SELECT DimProduct.ProductKey
	,EnglishProductName
	,Color
	,StandardCost
FROM DimProduct LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubCategoryKey


--Req#2.2 Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria DimProduct, DimProductSubcategory, DimProductCategory).
SELECT DimProduct.ProductKey
	,EnglishProductName
	,Color
	,StandardCost
FROM DimProduct
	LEFT JOIN DimProductSubcategory
		ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubCategoryKey
	LEFT JOIN DimProductCategory
		ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

--Req#2.3 Esponi lʼelenco dei soli prodotti venduti DimProduct, FactResellerSales).
SELECT DimProduct.ProductKey
	,EnglishProductName
	,Color
	,StandardCost
	,FactResellerSales.SalesOrderNumber
FROM DimProduct
	INNER JOIN FactResellerSales
		ON DimProduct.ProductKey = FactResellerSales.ProductKey

--Req#2.4 Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1.
SELECT DimProduct.ProductKey
	,EnglishProductName
	,Color
	,StandardCost
FROM DimProduct
WHERE DimProduct.ProductKey NOT IN (
	SELECT FactResellerSales.ProductKey
	FROM FactResellerSales
	) 
AND FinishedGoodsFlag = 1

--Req#2.5 Esponi lʼelenco delle transazioni di vendita FactResellerSales) indicando anche il nome del prodotto venduto DimProduct)
SELECT SalesOrderNumber
	,OrderDate
	,DimProduct.EnglishProductName
	,SalesAmount
FROM FactResellerSales
	INNER JOIN DimProduct
		ON FactResellerSales.ProductKey = DimProduct.ProductKey


--Req#3.1 Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.
SELECT SalesOrderNumber
	,OrderDate
	,DimProduct.EnglishProductName
	,SalesAmount
	,DimProductSubcategory.EnglishProductSubcategoryName
FROM FactResellerSales
	INNER JOIN DimProduct
		ON FactResellerSales.ProductKey = DimProduct.ProductKey
	INNER JOIN DimProductSubcategory
		ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubCategoryKey

--Req3.2 Esplora la tabella DimReseller.
SELECT *
FROM DimReseller

--Req3.3 Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 
SELECT *
FROM DimReseller
	INNER JOIN DimGeography
		ON DimReseller.GeographyKey = DimGeography.GeographyKey

/*Req3.4
Esponi lʼelenco delle transazioni di vendita.
Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.
*/
SELECT fs.SalesOrderNumber
    ,fs.SalesOrderLineNumber
    ,fs.OrderDate
    ,fs.UnitPrice
    ,fs.OrderQuantity AS Quantity
	,fs.TotalProductCost
    ,p.EnglishProductName AS ProductName
    ,pc.EnglishProductCategoryName AS ProductCategory
    ,r.ResellerName
    ,g.EnglishCountryRegionName AS GeographicArea
FROM FactResellerSales fs
    INNER JOIN DimProduct p
        ON fs.ProductKey = p.ProductKey
    INNER JOIN DimProductSubcategory ps
        ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
    INNER JOIN DimProductCategory pc
        ON ps.ProductCategoryKey = pc.ProductCategoryKey
    INNER JOIN DimReseller r
        ON fs.ResellerKey = r.ResellerKey
    INNER JOIN DimGeography g
        ON r.GeographyKey = g.GeographyKey