USE [AdventureWorksStaging]
GO
/****** Object:  StoredProcedure [dbo].[sp_IncrementalLoad_PurchaseOrderHeader]    Script Date: 7/2/2024 7:06:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_IncrementalLoad_PurchaseOrderHeader]
AS
BEGIN
    DECLARE @LastModifiedDate DATETIME;
    DECLARE @CurrentMaxModifiedDate DATETIME;
    -- Get the last modified date from the control table
    SELECT @LastModifiedDate = LastModifiedDate
    FROM AdventureWorksStaging.dbo.IncrementalLoadControl
    WHERE TableName = 'purchasing_StagingPurchaseOrderHeader';
    -- If no record exists, set @LastModifiedDate to a very old date
    IF @LastModifiedDate IS NULL
    BEGIN
        SET @LastModifiedDate = '1900-01-01';
    END;
    -- Perform the incremental load
    INSERT INTO AdventureWorksStaging.dbo.purchasing_StagingPurchaseOrderHeader (
        PurchaseOrderID,
        RevisionNumber,
        Status,
        EmployeeID,
        VendorID,
        ShipMethodID,
        OrderDate,
        ShipDate,
        SubTotal,
        TaxAmt,
        Freight,
        TotalDue,
        ModifiedDate
    )
    SELECT
        PurchaseOrderID,
        RevisionNumber,
        Status,
        EmployeeID,
        VendorID,
        ShipMethodID,
        OrderDate,
        ShipDate,
        SubTotal,
        TaxAmt,
        Freight,
        TotalDue,
        ModifiedDate
    FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader
    WHERE ModifiedDate > @LastModifiedDate;
    -- Update the control table with the current max modified date
    SELECT @CurrentMaxModifiedDate = MAX(ModifiedDate)
    FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader;
    IF @CurrentMaxModifiedDate IS NOT NULL
    BEGIN
        MERGE AdventureWorksStaging.dbo.IncrementalLoadControl AS target
        USING (SELECT 'purchasing_StagingPurchaseOrderHeader' AS TableName, @CurrentMaxModifiedDate AS LastModifiedDate) AS source
        ON target.TableName = source.TableName
        WHEN MATCHED THEN
            UPDATE SET target.LastModifiedDate = source.LastModifiedDate
        WHEN NOT MATCHED THEN
            INSERT (TableName, LastModifiedDate)
            VALUES (source.TableName, source.LastModifiedDate);
    END;
END;
