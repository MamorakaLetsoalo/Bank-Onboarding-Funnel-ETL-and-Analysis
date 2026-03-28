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

-- Create raw table
USE Banking_Raw;

CREATE TABLE raw.raw_onboarding_events (
    event_id INT,
    event_timestamp DATETIME,
    event_name VARCHAR(100),
    event_type VARCHAR(50),
    
    customer_identifier VARCHAR(50),
    session_id VARCHAR(50),
    attempt_id VARCHAR(50),
    
    channel VARCHAR(50),
    device_type VARCHAR(50),
    os VARCHAR(50),
    network_type VARCHAR(50),
    
    step_name VARCHAR(100),
    step_sequence INT,
    
    status VARCHAR(50),
    error_code VARCHAR(100),
    
    location_raw VARCHAR(100),
    ingestion_timestamp DATETIME,
    source_system VARCHAR(50)
);