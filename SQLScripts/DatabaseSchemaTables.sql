-- Raw layer (stores everything)
CREATE DATABASE Banking_Raw;

-- Staging layer(stores clean and standerdised data)
CREATE DATABASE Banking_Staging;

-- Warehouse layer(used for analysis)
CREATE DATABASE Banking_Warehouse;

--Create schemas 
USE Banking_Raw;
CREATE SCHEMA raw;

USE Banking_Staging;
CREATE SCHEMA staging;

USE Banking_Warehouse;
CREATE SCHEMA warehouse;