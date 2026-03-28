USE Banking_Warehouse;
-- create fact table
CREATE TABLE dbo.fact_onboarding_funnel (
    funnel_fact_id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,

    customer_id INT,
    channel_id INT,
    step_id INT,
    date_id INT,
    device_id INT,
    location_id INT,

    attempt_id VARCHAR(50),
    step_sequence INT,

    step_status VARCHAR(20),
    drop_off_flag BIT,
    completion_flag BIT,

    time_spent_seconds INT
);
