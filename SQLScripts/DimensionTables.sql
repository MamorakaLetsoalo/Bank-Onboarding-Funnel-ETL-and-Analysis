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