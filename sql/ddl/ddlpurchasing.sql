USE [AdventureWorksStaging]
GO
/****** Object:  StoredProcedure [dbo].[ddlpurchasing]    Script Date: 7/2/2024 6:58:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ddlpurchasing]
AS
BEGIN
    -- Create StagingVendor table
    CREATE TABLE purchasing_StagingVendor (
        BusinessEntityID INT PRIMARY KEY,
        AccountNumber NVARCHAR(15),
        Name NVARCHAR(50),
        CreditRating TINYINT,
        PreferredVendorStatus BIT,
        ActiveFlag BIT,
        PurchasingWebServiceURL NVARCHAR(1024),
        ModifiedDate DATETIME
    );

    -- Create StagingProductVendor table
    CREATE TABLE purchasing_StagingProductVendor (
        ProductID INT,
        BusinessEntityID INT,
        AverageLeadTime INT,
        StandardPrice MONEY,
        LastReceiptCost MONEY,
        LastReceiptDate DATETIME,
        MinOrderQty INT,
        MaxOrderQty INT,
        OnOrderQty INT,
        UnitMeasureCode NCHAR(3),
        ModifiedDate DATETIME,
        PRIMARY KEY (ProductID, BusinessEntityID)
    );

    -- Create StagingPurchaseOrderDetail table
    CREATE TABLE  purchasing_StagingPurchaseOrderDetail (
        PurchaseOrderID INT,
        PurchaseOrderDetailID INT,
        DueDate DATETIME,
        OrderQty SMALLINT,
        ProductID INT,
        UnitPrice MONEY,
        LineTotal MONEY,
        ReceivedQty FLOAT,
        RejectedQty FLOAT,
        StockedQty FLOAT,
        ModifiedDate DATETIME,

    );

    -- Create StagingPurchaseOrderHeader table
    CREATE TABLE  purchasing_StagingPurchaseOrderHeader (
        PurchaseOrderID INT PRIMARY KEY,
        RevisionNumber TINYINT,
        Status TINYINT,
        EmployeeID INT,
        VendorID INT,
        ShipMethodID INT,
        OrderDate DATETIME,
        ShipDate DATETIME,
        SubTotal MONEY,
        TaxAmt MONEY,
        Freight MONEY,
        TotalDue MONEY,
        ModifiedDate DATETIME
    );

    -- Create StagingShipMethod table
    CREATE TABLE  purchasing_StagingShipMethod (
        ShipMethodID INT PRIMARY KEY,
        Name NVARCHAR(50),
        ShipBase MONEY,
        ShipRate MONEY,
        ModifiedDate DATETIME
    );
END;
