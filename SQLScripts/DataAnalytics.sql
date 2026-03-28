USE Banking_Warehouse
GO
-- Funnel KPI View
CREATE VIEW dbo.vw_onboarding_kpi_overall AS 
SELECT 
    COUNT(DISTINCT customer_id) AS total_users,

    SUM(CASE WHEN step_sequence = 1 THEN 1 ELSE 0 END) AS started_users,

    SUM(CAST(completion_flag AS INT)) AS completed_users,
    SUM(CAST(drop_off_flag AS INT)) AS dropped_users,

    CAST(
        SUM(CAST(completion_flag AS INT)) * 1.0 
        / COUNT(DISTINCT customer_id) 
    AS DECIMAL(10,4)) AS conversion_rate,

    CAST(
        SUM(CAST(drop_off_flag AS INT)) * 1.0 
        / COUNT(DISTINCT customer_id) 
    AS DECIMAL(10,4)) AS drop_off_rate

FROM dbo.fact_onboarding_funnel;

GO
-- Onboarding funnel view
CREATE VIEW dbo.vw_onboarding_funnel AS
SELECT 
    s.step_order,
    s.step_name,

    COUNT(DISTINCT f.customer_id) AS users_entering_step,

    LAG(COUNT(DISTINCT f.customer_id)) OVER (ORDER BY s.step_order) AS previous_step_users,

    COUNT(DISTINCT f.customer_id) - 
    LAG(COUNT(DISTINCT f.customer_id)) OVER (ORDER BY s.step_order) AS drop_offs,

    CAST(COUNT(DISTINCT f.customer_id) * 1.0 /
         FIRST_VALUE(COUNT(DISTINCT f.customer_id)) OVER (ORDER BY s.step_order) 
    AS DECIMAL(10,4)) AS step_conversion_rate

FROM dbo.fact_onboarding_funnel f
JOIN dbo.dim_step s ON f.step_id = s.step_id

GROUP BY s.step_order, s.step_name;

GO

--Time and behaivour view
CREATE VIEW dbo.vw_onboarding_behavior AS
SELECT
    s.step_name,
    AVG(time_spent_seconds) AS avg_time_spent,
    MIN(time_spent_seconds) AS min_time,
    MAX(time_spent_seconds) AS max_time,

    COUNT(*) AS total_records
FROM dbo.fact_onboarding_funnel f
JOIN dbo.dim_step s ON f.step_id = s.step_id
GROUP BY s.step_name;

GO

--channel performance view
CREATE VIEW dbo.vw_onboarding_channel AS
SELECT
    c.channel_name,

    COUNT(DISTINCT f.customer_id) AS total_users,

    SUM(CASE WHEN f.completion_flag = 1 THEN 1 ELSE 0 END) AS completed_users,
    SUM(CASE WHEN f.drop_off_flag = 1 THEN 1 ELSE 0 END) AS dropped_users,

    CAST(
        SUM(CASE WHEN f.completion_flag = 1 THEN 1 ELSE 0 END) * 1.0 
        / COUNT(DISTINCT f.customer_id)
    AS DECIMAL(10,4)) AS conversion_rate

FROM dbo.fact_onboarding_funnel f
JOIN dbo.dim_channel c 
    ON f.channel_id = c.channel_id
GROUP BY c.channel_name;