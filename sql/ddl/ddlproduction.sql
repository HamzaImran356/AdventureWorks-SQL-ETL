USE [AdventureWorksStaging]
GO
/****** Object:  StoredProcedure [dbo].[ddlproduction]    Script Date: 7/2/2024 6:58:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ddlproduction]
AS
BEGIN
    -- Create StagingProduct table
    CREATE TABLE production_StagingProduct (
        ProductID INT,
        Name NVARCHAR(255),
        ProductNumber NVARCHAR(25),
        MakeFlag BIT,
        FinishedGoodsFlag BIT,
        Color NVARCHAR(15),
        SafetyStockLevel SMALLINT,
        ReorderPoint SMALLINT,
        StandardCost MONEY,
        ListPrice MONEY,
        Size NVARCHAR(5),
        Weight DECIMAL(8, 2),
        DaysToManufacture INT,
        ProductLine NVARCHAR(2),
        Class NVARCHAR(2),
        Style NVARCHAR(2),
        ProductSubcategoryID INT,
        ProductModelID INT,
        SellStartDate DATETIME,
        SellEndDate DATETIME,
        DiscontinuedDate DATETIME,
        ModifiedDate DATETIME
    );

    -- Create StagingProductCategory table
    CREATE TABLE production_StagingProductCategory (
        ProductCategoryID INT PRIMARY KEY,
        Name NVARCHAR(50),
        ModifiedDate DATETIME
    );

    -- Create StagingProductSubcategory table
    CREATE TABLE production_StagingProductSubcategory (
        ProductSubcategoryID INT PRIMARY KEY,
        ProductCategoryID INT,
        Name NVARCHAR(50),
        ModifiedDate DATETIME
    );



    -- Create StagingBillOfMaterials table
    CREATE TABLE production_StagingBillOfMaterials (
        BillOfMaterialsID INT PRIMARY KEY,
        ProductAssemblyID INT,
        ComponentID INT,
        StartDate DATETIME,
        EndDate DATETIME,
        BOMLevel SMALLINT,
        PerAssemblyQty DECIMAL(8, 2),
        ModifiedDate DATETIME
    );

    -- Create StagingProductInventory table
    CREATE TABLE production_StagingProductInventory (
        ProductID INT ,
        LocationID INT,
        Shelf NVARCHAR(10),
        Bin NVARCHAR(10),
        Quantity INT,
        ModifiedDate DATETIME
    );

    -- Create StagingProductCostHistory table
    CREATE TABLE production_StagingProductCostHistory (
        ProductID INT,
        StartDate DATETIME,
        EndDate DATETIME,
        StandardCost MONEY,
        ModifiedDate DATETIME,

    );

    -- Create StagingProductPriceHistory table
    CREATE TABLE production_StagingProductlistPriceHistory (
        ProductID INT,
        StartDate DATETIME,
        EndDate DATETIME,
        ListPrice MONEY,
        ModifiedDate DATETIME,
    );

    -- Create StagingUnitMeasure table
    CREATE TABLE production_StagingUnitMeasure (
        UnitMeasureCode NVARCHAR(3) PRIMARY KEY,
        Name NVARCHAR(50),
        ModifiedDate DATETIME
    );

    -- Create StagingLocation table
    CREATE TABLE production_StagingLocation (
        LocationID INT PRIMARY KEY,
        Name NVARCHAR(50),
        CostRate MONEY,
        Availability INT,
        ModifiedDate DATETIME
    );

    END;
