--Req#2.1 Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?

--Ragionamento: Verifico l'unicità della chiave e che non ci siano campi null
SELECT 
    dp.ProductKey,
    dp.EnglishProductName,
    COUNT(*) AS ProductUnique,
    (SELECT COUNT(*) FROM DimProduct WHERE ProductKey IS NULL) AS NullCount
FROM DimProduct dp
GROUP BY dp.ProductKey, dp.EnglishProductName
HAVING COUNT(*) = 1;

--Req#2.2 Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
SELECT 
    (SELECT COUNT(*) 
     FROM (
        SELECT SalesOrderNumber, SalesOrderLineNumber
        FROM FactResellerSales
        GROUP BY SalesOrderNumber, SalesOrderLineNumber
        HAVING COUNT(*) > 1
     ) AS Dup) AS DuplicateCount,
    (SELECT COUNT(*) 
     FROM FactResellerSales
     WHERE SalesOrderNumber IS NULL 
        OR SalesOrderLineNumber IS NULL) AS NullCount;

--Req#2.3 Conta il numero transazioni SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
SELECT OrderDate
    ,COUNT(SalesOrderLineNumber) AS TransactionsPerDay
FROM FactResellerSales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate
ORDER BY OrderDate;

/*
--Req#2.4
Calcola il fatturato totale FactResellerSales.SalesAmount), la quantità totale venduta FactResellerSales.OrderQuantity) e
il prezzo medio di vendita FactResellerSales.UnitPrice) per prodotto DimProduct) a partire dal 1 Gennaio 2020. 
Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
I campi in output devono essere parlanti!
*/
SELECT p.EnglishProductName AS ProductName,
    SUM(f.SalesAmount) AS TotalSalesAmount,
    SUM(f.OrderQuantity) AS TotalOrderQuantity,
    AVG(f.UnitPrice) AS AverageUnitPrice
FROM FactResellerSales f
INNER JOIN DimProduct p
    ON f.ProductKey = p.ProductKey
WHERE f.OrderDate >= '2020-01-01'
GROUP BY p.EnglishProductName
ORDER BY TotalSalesAmount DESC;

/*
Req#3.1
Calcola il fatturato totale FactResellerSales.SalesAmount) e la quantità totale venduta FactResellerSales.OrderQuantity) per Categoria prodotto DimProductCategory).
Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. 
I campi in output devono essere parlanti!
*/
SELECT 
    pc.EnglishProductCategoryName AS Category,
    SUM(fr.SalesAmount) AS TotalSalesAmount,
    SUM(fr.OrderQuantity) AS TotalOrderQuantity
FROM FactResellerSales fr
INNER JOIN DimProduct p
    ON fr.ProductKey = p.ProductKey
INNER JOIN DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY pc.EnglishProductCategoryName
ORDER BY TotalSalesAmount DESC;

--Req#3.2 Calcola il fatturato totale per area città DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.
SELECT g.City,
    SUM(fr.SalesAmount) AS TotalSalesAmount
FROM FactResellerSales fr
INNER JOIN DimReseller r
    ON fr.ResellerKey = r.ResellerKey
INNER JOIN DimGeography g
    ON r.GeographyKey = g.GeographyKey
WHERE fr.OrderDate >= '2020-01-01'
GROUP BY g.City
HAVING SUM(fr.SalesAmount) > 60000
ORDER BY TotalSalesAmount DESC;