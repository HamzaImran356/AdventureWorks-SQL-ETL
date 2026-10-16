USE [AdventureWorksStaging]
GO
/****** Object:  StoredProcedure [dbo].[sp_IncrementalLoad_SalesOrderHeader]    Script Date: 7/2/2024 7:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_IncrementalLoad_SalesOrderHeader]
AS
BEGIN
    DECLARE @LastModifiedDate DATETIME;
    DECLARE @CurrentMaxModifiedDate DATETIME;

    -- Get the last modified date from the control table
    SELECT @LastModifiedDate = LastModifiedDate
    FROM AdventureWorksStaging.dbo.IncrementalLoadControl
    WHERE TableName = 'sales_StagingSalesOrderHeader';

    -- If no record exists, set @LastModifiedDate to a very old date
    IF @LastModifiedDate IS NULL
    BEGIN
        SET @LastModifiedDate = '1900-01-01';
    END

    -- Perform the incremental load
    INSERT INTO AdventureWorksStaging.dbo.sales_StagingSalesOrderHeader (SalesOrderID,RevisionNumber,OrderDate,DueDate
,ShipDate,Status,OnlineOrderFlag,SalesOrderNumber,PurchaseOrderNumber,AccountNumber,CustomerID,SalesPersonID,TerritoryID,BillToAddressID,ShipToAddressID,ShipMethodID,CreditCardID,CreditCardApprovalCode,CurrencyRateID,SubTotal,TaxAmt,Freight,TotalDue,Comment,ModifiedDate)
    SELECT SalesOrderID,RevisionNumber,OrderDate,DueDate
,ShipDate,Status,OnlineOrderFlag,SalesOrderNumber,PurchaseOrderNumber,AccountNumber,CustomerID,SalesPersonID,TerritoryID,BillToAddressID,ShipToAddressID,ShipMethodID,CreditCardID,CreditCardApprovalCode,CurrencyRateID,SubTotal,TaxAmt,Freight,TotalDue,Comment,ModifiedDate
    FROM AdventureWorks2022.Sales.SalesOrderHeader
    WHERE ModifiedDate > @LastModifiedDate;

    -- Update the control table with the current max modified date
    SELECT @CurrentMaxModifiedDate = MAX(ModifiedDate)
    FROM AdventureWorks2022.Sales.SalesOrderHeader;

    IF @CurrentMaxModifiedDate IS NOT NULL
    BEGIN
        MERGE AdventureWorksStaging.dbo.IncrementalLoadControl AS target
        USING (SELECT 'sales_StagingSalesOrderHeader' AS TableName, @CurrentMaxModifiedDate AS LastModifiedDate) AS source
        ON target.TableName = source.TableName
        WHEN MATCHED THEN
            UPDATE SET target.LastModifiedDate = source.LastModifiedDate
        WHEN NOT MATCHED THEN
            INSERT (TableName, LastModifiedDate)
            VALUES (source.TableName, source.LastModifiedDate);
    END
END;
