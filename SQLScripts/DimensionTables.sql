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