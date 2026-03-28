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

USE Banking_Warehouse;
GO

--check if dim tables exist
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE 'dim_%';
 
 --Adding additional information
ALTER TABLE Banking_Staging.staging.stg_onboarding_events
ADD attempt_id VARCHAR(50);

ALTER TABLE Banking_Staging.staging.stg_onboarding_events
ADD customer_identifier VARCHAR(50);

ALTER TABLE Banking_Staging.staging.stg_onboarding_events
ADD channel_name VARCHAR(50);



--verify staging structure
SELECT TOP 10 * 
FROM Banking_Staging.staging.stg_onboarding_events;


--load fact table
INSERT INTO dbo.fact_onboarding_funnel (
    customer_id,
    channel_id,
    step_id,
    date_id,
    device_id,
    location_id,
    attempt_id,
    step_sequence,
    step_status,
    drop_off_flag,
    completion_flag,
    time_spent_seconds
)
SELECT
    dc.customer_id,
    ch.channel_id,
    ds.step_id,
    dd.date_id,
    dv.device_id,
    dl.location_id,

    e.attempt_id,
    e.step_sequence,

    CASE 
        WHEN e.is_success = 1 THEN 'Completed'
        ELSE 'Dropped'
    END,

    CASE 
        WHEN LEAD(e.step_sequence) OVER (
            PARTITION BY e.customer_id 
            ORDER BY e.event_timestamp
        ) IS NULL 
        AND e.step_sequence < 6 THEN 1
        ELSE 0
    END,

    CASE 
        WHEN e.step_sequence = 6 AND e.is_success = 1 THEN 1
        ELSE 0
    END,

    DATEDIFF(
        SECOND,
        LAG(e.event_timestamp) OVER (
            PARTITION BY e.customer_id 
            ORDER BY e.event_timestamp
        ),
        e.event_timestamp
    )

FROM Banking_Staging.staging.stg_onboarding_events e

LEFT JOIN dbo.dim_customer dc 
    ON e.customer_id = dc.customer_identifier

LEFT JOIN dbo.dim_channel ch 
    ON e.channel = ch.channel_name

LEFT JOIN dbo.dim_step ds 
    ON e.step_name = ds.step_name

LEFT JOIN dbo.dim_date dd 
    ON CAST(e.event_timestamp AS DATE) = dd.full_date

LEFT JOIN dbo.dim_device dv 
    ON e.device_type = dv.device_type

LEFT JOIN dbo.dim_location dl 
    ON e.location = dl.city;