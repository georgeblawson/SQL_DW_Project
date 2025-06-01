/*
=========================================================================
Sript to Create Database and Schemas
=========================================================================
Script Purpose: Create the database DataWarehouse and the schemase 'brpnze', 'silver', 'gold'.
WARNING: Running the script will drop the DataWarhouse database if exists. All data in the db will be permenantly deleted.
*/


USE maseter;
GO

-- Drop and recreate the 'DataWarehouse' database
IS EXISTS (SELECT 1 FROM sys.databases WHERE name='DataWarehouse');
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO


-- Create 'DataWarehouse' db
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
