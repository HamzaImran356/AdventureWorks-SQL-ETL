USE [AdventureWorksStaging]
GO
/****** Object:  StoredProcedure [dbo].[ddlperson]    Script Date: 7/2/2024 6:56:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ddlperson]
AS
BEGIN
    -- Create StagingPerson table
    CREATE TABLE Person_StagingPerson (
        BusinessEntityID INT PRIMARY KEY,
        PersonType NCHAR(2),
        NameStyle BIT,
        Title NVARCHAR(8),
        FirstName NVARCHAR(50),
        MiddleName NVARCHAR(50),
        LastName NVARCHAR(50),
        Suffix NVARCHAR(10),
        EmailPromotion INT,
        ModifiedDate DATETIME
    );

    -- Create StagingPersonPhone table
    CREATE TABLE Person_StagingPersonPhone (
        BusinessEntityID INT,
        PhoneNumber NVARCHAR(25),
        PhoneNumberTypeID INT,
        ModifiedDate DATETIME,
        PRIMARY KEY (BusinessEntityID, PhoneNumber)
    );

    -- Create StagingEmailAddress table
    CREATE TABLE Person_StagingEmailAddress (
        BusinessEntityID INT,
        EmailAddressID INT,
        EmailAddress NVARCHAR(50),
        ModifiedDate DATETIME,
        PRIMARY KEY (BusinessEntityID, EmailAddressID)
    );

    -- Create StagingAddress table
    CREATE TABLE Person_StagingAddress (
        AddressID INT PRIMARY KEY,
        AddressLine1 NVARCHAR(60),
        AddressLine2 NVARCHAR(60),
        City NVARCHAR(30),
        StateProvinceID INT,
        PostalCode NVARCHAR(15),
        SpatialLocation GEOGRAPHY,
        ModifiedDate DATETIME
    );

    -- Create StagingBusinessEntity table
    CREATE TABLE Person_StagingBusinessEntity (
        BusinessEntityID INT PRIMARY KEY,
        ModifiedDate DATETIME
    );

    -- Create StagingBusinessEntityAddress table
    CREATE TABLE Person_StagingBusinessEntityAddress (
        BusinessEntityID INT,
        AddressID INT,
        AddressTypeID INT,
        ModifiedDate DATETIME,
        PRIMARY KEY (BusinessEntityID, AddressID, AddressTypeID)
    );

    -- Create StagingBusinessEntityContact table
    CREATE TABLE Person_StagingBusinessEntityContact (
        BusinessEntityID INT,
        PersonID INT,
        ContactTypeID INT,
        ModifiedDate DATETIME,
        PRIMARY KEY (BusinessEntityID, PersonID, ContactTypeID)
    );


    -- Create StagingCountryRegion table
    CREATE TABLE Person_StagingCountryRegion (
        CountryRegionCode NVARCHAR(3) PRIMARY KEY,
        Name NVARCHAR(50),
        ModifiedDate DATETIME
    );

    -- Create StagingStateProvince table
    CREATE TABLE Person_StagingStateProvince (
        StateProvinceID INT PRIMARY KEY,
        StateProvinceCode NVARCHAR(3),
        CountryRegionCode NVARCHAR(3),
        Name NVARCHAR(50),
        TerritoryID INT,
        SalesYTD MONEY,
        SalesLastYear MONEY,
        TaxRate DECIMAL(10,4),
        ModifiedDate DATETIME
    );

    -- Create StagingContactType table
    CREATE TABLE Person_StagingContactType (
        ContactTypeID INT PRIMARY KEY,
        Name NVARCHAR(50),
        ModifiedDate DATETIME
    );

    -- Create StagingAddressType table
    CREATE TABLE Person_StagingAddressType (
        AddressTypeID INT PRIMARY KEY,
        Name NVARCHAR(50),
        ModifiedDate DATETIME
    );

    -- Create StagingPhoneNumberType table
    CREATE TABLE Person_StagingPhoneNumberType (
        PhoneNumberTypeID INT PRIMARY KEY,
        Name NVARCHAR(50),
        ModifiedDate DATETIME
    );

	END
