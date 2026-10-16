USE [AdventureWorksStaging]
GO
/****** Object:  StoredProcedure [dbo].[ddlsales]    Script Date: 7/2/2024 6:59:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ddlsales]
AS
BEGIN
    -- Create StagingSalesOrderHeader table
    CREATE TABLE sales_StagingSalesOrderHeader (
        SalesOrderID INT ,
        RevisionNumber TINYINT,
        OrderDate DATETIME,
        DueDate DATETIME,
        ShipDate DATETIME,
        Status TINYINT,
        OnlineOrderFlag BIT,
        SalesOrderNumber NVARCHAR(25),
        PurchaseOrderNumber NVARCHAR(25),
        AccountNumber NVARCHAR(25),
        CustomerID INT,
        SalesPersonID INT,
        TerritoryID INT,
        BillToAddressID INT,
        ShipToAddressID INT,
        ShipMethodID INT,
        CreditCardID INT,
        CreditCardApprovalCode NVARCHAR(15),
        CurrencyRateID INT,
        SubTotal MONEY,
        TaxAmt MONEY,
        Freight MONEY,
        TotalDue MONEY,
        Comment NVARCHAR(MAX),
        ModifiedDate DATETIME
    );

    -- Create StagingSalesOrderDetail table
    CREATE TABLE sales_StagingSalesOrderDetail (
        SalesOrderDetailID INT ,
        SalesOrderID INT,
        CarrierTrackingNumber NVARCHAR(25),
        OrderQty SMALLINT,
        ProductID INT,
        SpecialOfferID INT,
        UnitPrice MONEY,
        UnitPriceDiscount MONEY,
        LineTotal MONEY,
        ModifiedDate DATETIME
    );

    -- Create StagingCustomer table
    CREATE TABLE sales_StagingCustomer (
        CustomerID INT PRIMARY KEY,
        PersonID INT NULL,
		StoreID INT null,
		TerritoryID INT null ,
		AccountNumber VARCHAR(10),
		ModifiedDate DateTime
		);

    -- Create StagingSalesPerson table
    CREATE TABLE sales_StagingSalesPerson (
        BusinessEntityID INT PRIMARY KEY,
        TerritoryID INT,
        SalesQuota MONEY,
        Bonus MONEY,
        CommissionPct DECIMAL(10,4),
        SalesYTD MONEY,
        SalesLastYear MONEY,
        ModifiedDate DATETIME
    );

    -- Create StagingStore table
    CREATE TABLE sales_StagingStore (
        BusinessEntityID INT PRIMARY KEY,
        Name NVARCHAR(50),
        SalesPersonID INT,
        ModifiedDate DATETIME
    );

    -- Create StagingSpecialOffer table
    CREATE TABLE sales_StagingSpecialOffer (
        SpecialOfferID INT PRIMARY KEY,
        Description NVARCHAR(255),
        DiscountPct DECIMAL(10,4),
        Type NVARCHAR(50),
        Category NVARCHAR(50),
        StartDate DATETIME,
        EndDate DATETIME,
        MinQty INT,
        MaxQty INT,
        ModifiedDate DATETIME
    );

    -- Create sales_StagingCreditCard
    CREATE TABLE sales_StagingCreditCard (
        CreditCardID INT ,
        CardType NVARCHAR(50),
        CardNumber NVARCHAR(25),
        ExpMonth TINYINT,
        ExpYear SMALLINT,
        ModifiedDate DATETIME
    );

    -- Create sales_StagingPersonCreditCard
    CREATE TABLE sales_stagingPersonCreditCard (
        BusinessEntityID INT,
        CreditCardID INT,
        ModifiedDate DATETIME,

    );

    -- Create sales_StagingCurrencyRate
    CREATE TABLE sales_StagingCurrencyRate (
        CurrencyRateID INT ,
        CurrencyRateDate DATETIME,
        FromCurrencyCode NCHAR(3),
        ToCurrencyCode NCHAR(3),
        AverageRate MONEY,
        EndOfDayRate MONEY,
        ModifiedDate DATETIME
    );

    -- Create Sales_stagingSpecialOfferProduct
    CREATE TABLE Sales_stagingSpecialOfferProduct (
        SpecialOfferID INT,
        ProductID INT,
        ModifiedDate DATETIME,
    );

    -- Create sales_StagingCountryRegionCurrency
    CREATE TABLE sales_StagingCountryRegionCurrency (
        CountryRegionCode NCHAR(3),
        CurrencyCode NCHAR(3),
        ModifiedDate DATETIME,
        PRIMARY KEY (CountryRegionCode, CurrencyCode)
    );

    -- Create sales_StagingCurrency
    CREATE TABLE sales_StagingCurrency (
        CurrencyCode NCHAR(3) PRIMARY KEY,
        Name NVARCHAR(50),
        ModifiedDate DATETIME
    );

    -- Create sales_StagingSalesTaxRate
    CREATE TABLE sales_StagingSalesTaxRate (
        SalesTaxRateID INT PRIMARY KEY,
        StateProvinceID INT,
        TaxType TINYINT,
        TaxRate DECIMAL(10,4),
        Name NVARCHAR(50),
        ModifiedDate DATETIME
    );

    -- Create sales_StagingSalesTerritoryHistory
    CREATE TABLE sales_StagingSalesTerritoryHistory (
        BusinessEntityID INT,
        TerritoryID INT,
        StartDate DATETIME,
        EndDate DATETIME,
        ModifiedDate DATETIME,
    );

    -- Create sales_StagingShoppingCartItem
    CREATE TABLE sales_StagingShoppingCartItem (
        ShoppingCartItemID INT,
        ShoppingCartID NVARCHAR(50),
        Quantity INT,
        ProductID INT,
        DateCreated DATETIME,
        ModifiedDate DATETIME
    );
END;
