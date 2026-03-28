USE Banking_Warehouse;

-- dim customers
CREATE TABLE dbo.dim_customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,   -- surrogate key
    customer_identifier VARCHAR(50),             -- business key

    age_group VARCHAR(20),
    gender VARCHAR(10),
    income_band VARCHAR(20),
    employment_status VARCHAR(50),
    is_unbanked_flag BIT,
    kyc_level VARCHAR(20),

    effective_date DATETIME DEFAULT GETDATE(),
    expiry_date DATETIME,
    is_current BIT DEFAULT 1
);

--dim channel
CREATE TABLE dbo.dim_channel (
    channel_id INT IDENTITY(1,1) PRIMARY KEY,
    channel_name VARCHAR(50),
    channel_type VARCHAR(20)
);

--dim step
CREATE TABLE dbo.dim_step (
    step_id INT IDENTITY(1,1) PRIMARY KEY,
    step_name VARCHAR(100),
    step_order INT,
    is_mandatory_flag BIT
);

--dim date
CREATE TABLE dbo.dim_date (
    date_id INT PRIMARY KEY,   
    full_date DATE,
    day INT,
    month INT,
    year INT,
    week INT
);

--dim location
CREATE TABLE dbo.dim_location (
    location_id INT IDENTITY(1,1) PRIMARY KEY,
    country VARCHAR(50),
    province VARCHAR(50),
    city VARCHAR(50),
    urban_rural_flag VARCHAR(10)
);

--dim device
CREATE TABLE dbo.dim_device (
    device_id INT IDENTITY(1,1) PRIMARY KEY,
    device_type VARCHAR(50),
    os VARCHAR(50),
    network_type VARCHAR(20)
);

-- Load Dimension tables

--load dim channel
INSERT INTO dbo.dim_channel (channel_name, channel_type)
SELECT DISTINCT
    channel,
    CASE 
        WHEN channel IN ('USSD','Mobile App','Web') THEN 'Digital'
        ELSE 'Physical'
    END
FROM Banking_Staging.staging.stg_onboarding_events;

--Load dim step
INSERT INTO dbo.dim_step (step_name, step_order, is_mandatory_flag)
SELECT DISTINCT
    step_name,
    step_sequence,
    1
FROM Banking_Staging.staging.stg_onboarding_events;

--load dim location
INSERT INTO dbo.dim_location (country, province, city, urban_rural_flag)
SELECT DISTINCT
    'South Africa',
    'KwaZulu-Natal',
    location,
    'Urban'
FROM Banking_Staging.staging.stg_onboarding_events;

--load dim device
INSERT INTO dbo.dim_device (device_type, os, network_type)
SELECT DISTINCT
    device_type,
    'Android',
    '4G'
FROM Banking_Staging.staging.stg_onboarding_events;

--load dim date
INSERT INTO dbo.dim_date (date_id, full_date, day, month, year, week)
SELECT 
    t.date_id,
    t.full_date,
    t.day,
    t.month,
    t.year,
    t.week
FROM (
    SELECT DISTINCT
        CONVERT(INT, CONVERT(VARCHAR(8), event_timestamp, 112)) AS date_id,
        CAST(event_timestamp AS DATE) AS full_date,
        DAY(event_timestamp) AS day,
        MONTH(event_timestamp) AS month,
        YEAR(event_timestamp) AS year,
        DATEPART(WEEK, event_timestamp) AS week
    FROM Banking_Staging.staging.stg_onboarding_events
) t
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.dim_date d WHERE d.date_id = t.date_id
);

-- load dim customer
INSERT INTO dbo.dim_customer (
    customer_identifier,
    is_unbanked_flag,
    kyc_level
)
SELECT DISTINCT
    customer_id,
    1,              -- assume unbanked initially
    'LOW'
FROM Banking_Staging.staging.stg_onboarding_events;




