/*Req#1*/
CREATE VIEW Product AS (
	SELECT p.EnglishProductName
	  ,psc.EnglishProductSubcategoryName
	  ,pc.EnglishProductCategoryName
	FROM dimproduct as p
	INNER JOIN dimproductsubcategory as psc
	ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
	INNER JOIN dimproductcategory as pc
	ON pc.ProductCategoryKey = psc.ProductCategoryKey
);

/*Req#2*/
CREATE VIEW Reseller AS (
	SELECT r.ResellerName
	  ,g.City
	  ,g.EnglishCountryRegionName
	FROM dimreseller as r
	INNER JOIN dimgeography as g
	  ON r.GeographyKey = g.GeographyKey
);

/*Req#3*/
SELECT frs.OrderDate
  , frs.SalesOrderNumber
  , SUM(frs.OrderQuantity) as TotalQty
  , SUM(frs.UnitPrice) as TotalPrice
  , SUM(frs.UnitPrice) - SUM(frs.TotalProductCost) as TotalRevenue
FROM factresellersales as frs
GROUP BY frs.SalesOrderNumber;
