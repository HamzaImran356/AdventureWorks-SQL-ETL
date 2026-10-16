USE [AdventureWorksStaging]
GO
/****** Object:  StoredProcedure [dbo].[sp_FullLoadAdventureWorksStaging]    Script Date: 7/2/2024 7:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_FullLoadAdventureWorksStaging]
AS
BEGIN


    -- Truncate the specified tables
    TRUNCATE TABLE AdventureWorksStaging.dbo.purchasing_StagingVendor;
    TRUNCATE TABLE AdventureWorksStaging.dbo.purchasing_StagingProductVendor;
    TRUNCATE TABLE AdventureWorksStaging.dbo.purchasing_StagingShipMethod;
    TRUNCATE TABLE AdventureWorksStaging.dbo.production_StagingBillOfMaterials;
    TRUNCATE TABLE AdventureWorksStaging.dbo.production_StagingLocation;
    TRUNCATE TABLE AdventureWorksStaging.dbo.production_StagingProduct;
    TRUNCATE TABLE AdventureWorksStaging.dbo.production_StagingProductCategory;
    TRUNCATE TABLE AdventureWorksStaging.dbo.production_StagingProductCostHistory;
    TRUNCATE TABLE AdventureWorksStaging.dbo.production_StagingProductInventory;
    TRUNCATE TABLE AdventureWorksStaging.dbo.production_StagingProductlistPriceHistory;
    TRUNCATE TABLE AdventureWorksStaging.dbo.production_StagingProductSubcategory;
    TRUNCATE TABLE AdventureWorksStaging.dbo.production_StagingUnitMeasure;
    TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingPhoneNumberType;
	TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingPerson;
	TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingEmailAddress;
	TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingBusinessEntity
	TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingBusinessEntityAddress;
    TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingStateProvince;
    TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingCountryRegion;
	TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingPersonPhone;
    TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingContactType;
    TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingBusinessEntityContact;
    TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingAddressType;
	TRUNCATE TABLE AdventureWorksStaging.dbo.Person_StagingAddress;
    TRUNCATE TABLE AdventureWorksStaging.dbo.sales_StagingCountryRegionCurrency;
    TRUNCATE TABLE AdventureWorksStaging.dbo.sales_StagingCurrency;
    TRUNCATE TABLE AdventureWorksStaging.dbo.sales_StagingSalesPerson;
    TRUNCATE TABLE AdventureWorksStaging.dbo.sales_StagingSalesTaxRate;
    TRUNCATE TABLE AdventureWorksStaging.dbo.sales_StagingSalesTerritoryHistory;
    TRUNCATE TABLE AdventureWorksStaging.dbo.sales_StagingShoppingCartItem;
    TRUNCATE TABLE AdventureWorksStaging.dbo.sales_StagingSpecialOffer;
    TRUNCATE TABLE AdventureWorksStaging.dbo.Sales_stagingSpecialOfferProduct;
    TRUNCATE TABLE AdventureWorksStaging.dbo.sales_StagingStore;

	-- Insert data into Person_StagingPersonPhone
	INSERT INTO AdventureWorksStaging.dbo.Person_StagingPersonPhone (BusinessEntityID, PhoneNumber, PhoneNumberTypeID, ModifiedDate)
	SELECT BusinessEntityID, PhoneNumber, PhoneNumberTypeID, ModifiedDate
	FROM AdventureWorks2022.Person.PersonPhone;
	-- Insert data into Person_StagingPerson
	INSERT INTO AdventureWorksStaging.dbo.Person_StagingPerson (BusinessEntityID, PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, ModifiedDate)
	SELECT BusinessEntityID, PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, ModifiedDate
	FROM AdventureWorks2022.Person.Person;

	-- Insert data into Person_StagingEmailAddress
	INSERT INTO AdventureWorksStaging.dbo.Person_StagingEmailAddress (BusinessEntityID, EmailAddressID, EmailAddress, ModifiedDate)
	SELECT BusinessEntityID, EmailAddressID, EmailAddress, ModifiedDate
	FROM AdventureWorks2022.Person.EmailAddress;

	-- Insert data into Person_StagingBusinessEntityAddress
	INSERT INTO AdventureWorksStaging.dbo.Person_StagingBusinessEntityAddress (BusinessEntityID, AddressID, AddressTypeID, ModifiedDate)
	SELECT BusinessEntityID, AddressID, AddressTypeID, ModifiedDate
	FROM AdventureWorks2022.Person.BusinessEntityAddress;

	-- Insert data into Person_StagingBusinessEntity
	INSERT INTO AdventureWorksStaging.dbo.Person_StagingBusinessEntity (BusinessEntityID,ModifiedDate)
	SELECT BusinessEntityID, ModifiedDate
	FROM AdventureWorks2022.Person.BusinessEntity;

	-- Insert data into Person_StagingAddress
	INSERT INTO AdventureWorksStaging.dbo.Person_StagingAddress (AddressID, AddressLine1, AddressLine2, City, StateProvinceID, PostalCode, SpatialLocation, ModifiedDate)
	SELECT AddressID, AddressLine1, AddressLine2, City, StateProvinceID, PostalCode, SpatialLocation, ModifiedDate
	FROM AdventureWorks2022.Person.Address;

    INSERT INTO AdventureWorksStaging.dbo.purchasing_StagingVendor (BusinessEntityID, AccountNumber, Name, CreditRating, PreferredVendorStatus, ActiveFlag, PurchasingWebServiceURL, ModifiedDate)
    SELECT BusinessEntityID, AccountNumber, Name, CreditRating, PreferredVendorStatus, ActiveFlag, PurchasingWebServiceURL, ModifiedDate
    FROM AdventureWorks2022.Purchasing.Vendor;

    INSERT INTO AdventureWorksStaging.dbo.purchasing_StagingProductVendor (ProductID, BusinessEntityID, AverageLeadTime, StandardPrice, LastReceiptCost, LastReceiptDate, MinOrderQty, MaxOrderQty, OnOrderQty, ModifiedDate)
    SELECT ProductID, BusinessEntityID, AverageLeadTime, StandardPrice, LastReceiptCost, LastReceiptDate, MinOrderQty, MaxOrderQty, OnOrderQty, ModifiedDate
    FROM AdventureWorks2022.Purchasing.ProductVendor;

    INSERT INTO AdventureWorksStaging.dbo.purchasing_StagingShipMethod (ShipMethodID, Name, ShipBase, ShipRate, ModifiedDate)
    SELECT ShipMethodID, Name, ShipBase, ShipRate, ModifiedDate
    FROM AdventureWorks2022.Purchasing.ShipMethod;

    INSERT INTO AdventureWorksStaging.dbo.production_StagingBillOfMaterials (BillOfMaterialsID, ProductAssemblyID, ComponentID, StartDate, EndDate, BOMLevel, PerAssemblyQty, ModifiedDate)
    SELECT BillOfMaterialsID, ProductAssemblyID, ComponentID, StartDate, EndDate, BOMLevel, PerAssemblyQty, ModifiedDate
    FROM AdventureWorks2022.Production.BillOfMaterials;

    INSERT INTO AdventureWorksStaging.dbo.production_StagingLocation (LocationID, Name, CostRate, Availability, ModifiedDate)
    SELECT LocationID, Name, CostRate, Availability, ModifiedDate
    FROM AdventureWorks2022.Production.[Location];

    INSERT INTO AdventureWorksStaging.dbo.production_StagingProduct (ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, Weight, DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate, SellEndDate, DiscontinuedDate, ModifiedDate)
    SELECT ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, Weight, DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate, SellEndDate, DiscontinuedDate, ModifiedDate
    FROM AdventureWorks2022.Production.Product;

    INSERT INTO AdventureWorksStaging.dbo.production_StagingProductCategory (ProductCategoryID, Name, ModifiedDate)
    SELECT ProductCategoryID, Name, ModifiedDate
    FROM AdventureWorks2022.Production.ProductCategory;

    INSERT INTO AdventureWorksStaging.dbo.production_StagingProductCostHistory (ProductID, StartDate, EndDate, StandardCost, ModifiedDate)
    SELECT ProductID, StartDate, EndDate, StandardCost, ModifiedDate
    FROM AdventureWorks2022.Production.ProductCostHistory;

    INSERT INTO AdventureWorksStaging.dbo.production_StagingProductInventory (ProductID, LocationID, Shelf, Bin, Quantity, ModifiedDate)
    SELECT ProductID, LocationID, Shelf, Bin, Quantity, ModifiedDate
    FROM AdventureWorks2022.Production.ProductInventory;

    INSERT INTO AdventureWorksStaging.dbo.production_StagingProductlistPriceHistory (ProductID, StartDate, EndDate, ListPrice, ModifiedDate)
    SELECT ProductID, StartDate, EndDate, ListPrice, ModifiedDate
    FROM AdventureWorks2022.Production.ProductListPriceHistory;

    INSERT INTO AdventureWorksStaging.dbo.production_StagingProductSubcategory (ProductSubcategoryID, ProductCategoryID, Name, ModifiedDate)
    SELECT ProductSubcategoryID, ProductCategoryID, Name, ModifiedDate
    FROM AdventureWorks2022.Production.ProductSubcategory;

    INSERT INTO AdventureWorksStaging.dbo.production_StagingUnitMeasure (UnitMeasureCode, Name, ModifiedDate)
    SELECT UnitMeasureCode, Name, ModifiedDate
    FROM AdventureWorks2022.Production.UnitMeasure;

    INSERT INTO AdventureWorksStaging.dbo.Person_StagingPhoneNumberType (PhoneNumberTypeID, Name, ModifiedDate)
    SELECT PhoneNumberTypeID, Name, ModifiedDate
    FROM AdventureWorks2022.Person.PhoneNumberType;

    INSERT INTO AdventureWorksStaging.dbo.Person_StagingStateProvince (StateProvinceID, StateProvinceCode, CountryRegionCode, Name, TerritoryID, ModifiedDate)
    SELECT StateProvinceID, StateProvinceCode, CountryRegionCode, Name, TerritoryID, ModifiedDate
    FROM AdventureWorks2022.Person.StateProvince;

    INSERT INTO AdventureWorksStaging.dbo.Person_StagingCountryRegion (CountryRegionCode, Name, ModifiedDate)
    SELECT CountryRegionCode, Name, ModifiedDate
    FROM AdventureWorks2022.Person.CountryRegion;

    INSERT INTO AdventureWorksStaging.dbo.Person_StagingContactType (ContactTypeID, Name, ModifiedDate)
    SELECT ContactTypeID, Name, ModifiedDate
    FROM AdventureWorks2022.Person.ContactType;

    INSERT INTO AdventureWorksStaging.dbo.Person_StagingBusinessEntityContact (BusinessEntityID, PersonID, ContactTypeID, ModifiedDate)
    SELECT BusinessEntityID, PersonID, ContactTypeID, ModifiedDate
    FROM AdventureWorks2022.Person.BusinessEntityContact;

    INSERT INTO AdventureWorksStaging.dbo.Person_StagingAddressType (AddressTypeID, Name, ModifiedDate)
    SELECT AddressTypeID, Name, ModifiedDate
    FROM AdventureWorks2022.Person.AddressType;

    INSERT INTO AdventureWorksStaging.dbo.sales_StagingCountryRegionCurrency (CountryRegionCode, CurrencyCode, ModifiedDate)
    SELECT CountryRegionCode, CurrencyCode, ModifiedDate
    FROM AdventureWorks2022.Sales.CountryRegionCurrency;

    INSERT INTO AdventureWorksStaging.dbo.sales_StagingCurrency (CurrencyCode, Name, ModifiedDate)
    SELECT CurrencyCode, Name, ModifiedDate
    FROM AdventureWorks2022.Sales.Currency;

    INSERT INTO AdventureWorksStaging.dbo.sales_StagingSalesPerson (BusinessEntityID, TerritoryID, SalesQuota, Bonus, CommissionPct, SalesYTD, SalesLastYear, ModifiedDate)
    SELECT BusinessEntityID, TerritoryID, SalesQuota, Bonus, CommissionPct, SalesYTD, SalesLastYear, ModifiedDate
    FROM AdventureWorks2022.Sales.SalesPerson;

    INSERT INTO AdventureWorksStaging.dbo.sales_StagingSalesTaxRate (SalesTaxRateID, StateProvinceID, TaxType, TaxRate, Name, ModifiedDate)
    SELECT SalesTaxRateID, StateProvinceID, TaxType, TaxRate, Name, ModifiedDate
    FROM AdventureWorks2022.Sales.SalesTaxRate;

    INSERT INTO AdventureWorksStaging.dbo.sales_StagingSalesTerritoryHistory (BusinessEntityID, TerritoryID, StartDate, EndDate, ModifiedDate)
    SELECT BusinessEntityID, TerritoryID, StartDate, EndDate, ModifiedDate
    FROM AdventureWorks2022.Sales.SalesTerritoryHistory;

    INSERT INTO AdventureWorksStaging.dbo.sales_StagingShoppingCartItem (ShoppingCartItemID, ShoppingCartID, Quantity, ProductID, DateCreated, ModifiedDate)
    SELECT ShoppingCartItemID, ShoppingCartID, Quantity, ProductID, DateCreated, ModifiedDate
    FROM AdventureWorks2022.Sales.ShoppingCartItem;

    INSERT INTO AdventureWorksStaging.dbo.sales_StagingSpecialOffer (SpecialOfferID, Description, DiscountPct, Type, Category, StartDate, EndDate, MinQty, MaxQty, ModifiedDate)
    SELECT SpecialOfferID, Description, DiscountPct, Type, Category, StartDate, EndDate, MinQty, MaxQty, ModifiedDate
    FROM AdventureWorks2022.Sales.SpecialOffer;

    INSERT INTO AdventureWorksStaging.dbo.Sales_stagingSpecialOfferProduct (SpecialOfferID, ProductID,  ModifiedDate)
    SELECT SpecialOfferID, ProductID,  ModifiedDate
    FROM AdventureWorks2022.Sales.SpecialOfferProduct;

    INSERT INTO AdventureWorksStaging.dbo.sales_StagingStore (BusinessEntityID, Name, SalesPersonID, ModifiedDate)
    SELECT BusinessEntityID, Name, SalesPersonID, ModifiedDate
    FROM AdventureWorks2022.Sales.Store;


END
