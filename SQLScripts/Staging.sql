USE Banking_Staging
INSERT INTO staging.stg_onboarding_events
SELECT
    event_id,
    event_timestamp,
    
    -- Clean customer ID
    REPLACE(customer_identifier, '+27', '0') AS customer_id,
    
    LOWER(step_name) AS step_name,
    step_sequence,
    
    CASE 
        WHEN status = 'success' THEN 1
        ELSE 0
    END AS is_success,
    
    CASE 
        WHEN status IN ('fail','abandon') THEN 1
        ELSE 0
    END AS is_failure,
    
    channel,
    device_type,
    location_raw
    
FROM Banking_Raw.raw.raw_onboarding_events;

--depulicate and oder events
WITH ranked_events AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id, step_name 
               ORDER BY event_timestamp DESC
           ) AS rn
    FROM staging.stg_onboarding_events
)
SELECT * 
INTO staging.stg_onboarding_dedup
FROM ranked_events
WHERE rn = 1;