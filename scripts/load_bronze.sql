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

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

	TRUNCATE TABLE bronze.crm_cust_info;

	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,  
		FIELDTERMINATOR = ',',
		TABLOCK 
	);



	TRUNCATE TABLE bronze.crm_prd_info; 

	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,  
		FIELDTERMINATOR = ',', 
		TABLOCK 
	);




	TRUNCATE TABLE bronze.crm_sales_details; 

	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,  
		FIELDTERMINATOR = ',', 
		TABLOCK 
	);



	TRUNCATE TABLE bronze.erp_cust_az12;

	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
	WITH (
		FIRSTROW = 2,  
		FIELDTERMINATOR = ',', 
		TABLOCK 
	);


	TRUNCATE TABLE bronze.erp_loc_a101; 

	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
	WITH (
		FIRSTROW = 2,  
		FIELDTERMINATOR = ',', 
		TABLOCK 
	);


	TRUNCATE TABLE bronze.erp_px_cat_g1v2; 

	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\georg\OneDrive\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
	WITH (
		FIRSTROW = 2,  
		FIELDTERMINATOR = ',', 
		TABLOCK 
	);

END
