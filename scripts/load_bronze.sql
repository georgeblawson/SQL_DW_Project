/*
==============================================================================================================
Create a stored procedure to load the data into the bronze layer from the csv files
==============================================================================================================
This can be ran using EXEC bronze.load_bronze 


TRUNCATE TABLE bronze.crm_cust_info; --First make the table empty then load in the data (this avoids dupes)

Then the following parameters are used:
    FIRSTROW = 2,  --This is because the file has a header row
		FIELDTERMINATOR = ',', --csv files
		TABLOCK --This locks the whole table while the insert is happening, this hint reduces amount of logging so sql server can insert faster

PRINT statements added to use for logging
TRY and CATCH used for error handling
start and end time diff used to track load times of each table.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '======================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '======================================================================';

		PRINT '----------------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Tuncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>------------------------------------------';



		SET @start_time = GETDATE();
		PRINT '>> Tuncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info; 
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',', 
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>------------------------------------------';



		SET @start_time = GETDATE();
		PRINT '>> Tuncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details; 
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',', 
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>------------------------------------------';



		PRINT '----------------------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Tuncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',', 
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Tuncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101; 
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',', 
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Tuncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2; 
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,  
			FIELDTERMINATOR = ',', 
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>------------------------------------------';

	SET @batch_end_time = GETDATE();
	PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	PRINT 'Batch Load time: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	PRINT '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'


	END TRY
	
	BEGIN CATCH
		PRINT '======================================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT '======================================================================'; 
	END CATCH
END

