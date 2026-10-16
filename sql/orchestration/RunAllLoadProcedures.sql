USE [AdventureWorksStaging]
GO
/****** Object:  StoredProcedure [dbo].[sp_RunAllLoadProcedures]    Script Date: 7/2/2024 7:10:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_RunAllLoadProcedures]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME;
    DECLARE @ProcedureName NVARCHAR(255);
    DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @Status NVARCHAR(50);

    BEGIN TRY
        -- Execute full load procedure
        SET @ProcedureName = 'sp_FullLoadAdventureWorksStaging';
        SET @StartTime = GETDATE();
        EXEC sp_FullLoadAdventureWorksStaging;
        SET @Status = 'Success';
        INSERT INTO ProcedureExecutionAudit (ProcedureName, ExecutionTime, Status, ErrorMessage)
        VALUES (@ProcedureName, @StartTime, @Status, NULL);

        -- Execute incremental load procedures
        SET @ProcedureName = 'sp_IncrementalLoad_PurchaseOrderDetail';
        SET @StartTime = GETDATE();
        EXEC sp_IncrementalLoad_PurchaseOrderDetail;
        SET @Status = 'Success';
        INSERT INTO ProcedureExecutionAudit (ProcedureName, ExecutionTime, Status, ErrorMessage)
        VALUES (@ProcedureName, @StartTime, @Status, NULL);

        SET @ProcedureName = 'sp_IncrementalLoad_PurchaseOrderHeader';
        SET @StartTime = GETDATE();
        EXEC sp_IncrementalLoad_PurchaseOrderHeader;
        SET @Status = 'Success';
        INSERT INTO ProcedureExecutionAudit (ProcedureName, ExecutionTime, Status, ErrorMessage)
        VALUES (@ProcedureName, @StartTime, @Status, NULL);

        SET @ProcedureName = 'sp_IncrementalLoad_SalesCurrencyRate';
        SET @StartTime = GETDATE();
        EXEC sp_IncrementalLoad_SalesCurrencyRate;
        SET @Status = 'Success';
        INSERT INTO ProcedureExecutionAudit (ProcedureName, ExecutionTime, Status, ErrorMessage)
        VALUES (@ProcedureName, @StartTime, @Status, NULL);

        SET @ProcedureName = 'sp_IncrementalLoad_SalesOrderDetail';
        SET @StartTime = GETDATE();
        EXEC sp_IncrementalLoad_SalesOrderDetail;
        SET @Status = 'Success';
        INSERT INTO ProcedureExecutionAudit (ProcedureName, ExecutionTime, Status, ErrorMessage)
        VALUES (@ProcedureName, @StartTime, @Status, NULL);

        SET @ProcedureName = 'sp_IncrementalLoad_SalesOrderHeader';
        SET @StartTime = GETDATE();
        EXEC sp_IncrementalLoad_SalesOrderHeader;
        SET @Status = 'Success';
        INSERT INTO ProcedureExecutionAudit (ProcedureName, ExecutionTime, Status, ErrorMessage)
        VALUES (@ProcedureName, @StartTime, @Status, NULL);
    END TRY
    BEGIN CATCH
        -- Error handling
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @Status = 'Failure';

        INSERT INTO ProcedureExecutionAudit (ProcedureName, ExecutionTime, Status, ErrorMessage)
        VALUES (@ProcedureName, @StartTime, @Status, @ErrorMessage);

        -- Rethrow the error
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
