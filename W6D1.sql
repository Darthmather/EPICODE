--Req#2.2 Esplora la tabelle dei prodotti DimProduct)
SELECT *
  FROM DimProduct

--Req#2.3 Interroga la tabella dei prodotti DimProduct)
SELECT [ProductKey]
      ,[ProductAlternateKey]
      ,[EnglishProductName]
      ,[Color]
      ,[StandardCost]
      ,[FinishedGoodsFlag] AS EndProduct
  FROM [dbo].[DimProduct]

--Req#2.4 output i soli prodotti finiti
SELECT [ProductKey]
      ,[ProductAlternateKey]
      ,[EnglishProductName]
      ,[Color]
      ,[StandardCost]
  FROM [dbo].[DimProduct]
  WHERE [FinishedGoodsFlag] = 1

--Req#2.5 [ProductAlternateKey] comincia con FR oppure BK
SELECT [ProductKey]
      ,[ProductAlternateKey]
      ,[EnglishProductName]
      ,[StandardCost]
      ,[ListPrice]
      ,[ModelName]
  FROM [dbo].[DimProduct]
  WHERE [ProductAlternateKey] LIKE 'FR%'
    OR [ProductAlternateKey] LIKE 'BK%'

--Req#3.1  Markup applicato dallʼazienda ListPrice - StandardCost)
SELECT [ProductKey]
      ,[ProductAlternateKey]
      ,[EnglishProductName]
      ,[StandardCost]
      ,[ListPrice]
      ,[ModelName]
      ,([ListPrice] - [StandardCost]) as Markup
  FROM [dbo].[DimProduct]
  WHERE [ProductAlternateKey] LIKE 'FR%' OR [ProductAlternateKey] LIKE 'BK%'

--Req#3.2 Elenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000
SELECT [ProductKey]
      ,[ProductAlternateKey]
      ,[EnglishProductName]
      ,[StandardCost]
      ,[ListPrice]
      ,[ModelName]
  FROM [dbo].[DimProduct]
  WHERE [FinishedGoodsFlag] = 1
    AND [ListPrice] BETWEEN 1000 AND 2000

--Req3.3 Esplora la tabella degli impiegati aziendali DimEmployee)
SELECT *
  FROM [DimEmployee]

--Req3.4 elenco dei soli agenti
SELECT *
  FROM [DimEmployee]
  WHERE [SalesPersonFlag] = 1


--Req3.5 Interroga la tabella delle vendite FactResellerSales)
  --Esponi in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214.
  --Calcola per ciascuna transazione il profitto SalesAmount - TotalProductCost).
SELECT *
      ,([SalesAmount] - [TotalProductCost]) AS Profit
  FROM [FactResellerSales]
  WHERE [OrderDate] >= '2020-01-01' 
    AND [ProductKey] IN (597, 598, 477, 214)