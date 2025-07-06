{{ config(materialized='table') }}

WITH date_range AS (
    SELECT
        date('2020-01-01', '+' || n || ' day') AS date_day
    FROM (
        SELECT
            ROW_NUMBER() OVER () - 1 AS n
        FROM
            (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) t1,
            (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) t2,
            (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) t3
    )
    WHERE n < 3653 -- 10 years of days
)

SELECT
    date_day AS date,
    CAST(strftime('%Y', date_day) AS INTEGER) AS year,
    CAST(strftime('%m', date_day) AS INTEGER) AS month,
    CAST(strftime('%d', date_day) AS INTEGER) AS day,
    CAST(strftime('%w', date_day) AS INTEGER) AS day_of_week,
    strftime('%W', date_day) AS week_of_year,
    strftime('%Y-%m', date_day) AS year_month,
    strftime('%Y-%W', date_day) AS year_week,
    CASE strftime('%w', date_day)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_name,
    CASE strftime('%m', date_day)
        WHEN '01' THEN 'January'
        WHEN '02' THEN 'February'
        WHEN '03' THEN 'March'
        WHEN '04' THEN 'April'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'June'
        WHEN '07' THEN 'July'
        WHEN '08' THEN 'August'
        WHEN '09' THEN 'September'
        WHEN '10' THEN 'October'
        WHEN '11' THEN 'November'
        WHEN '12' THEN 'December'
    END AS month_name,
    CASE
        WHEN strftime('%m', date_day) IN ('12', '01', '02') THEN 'Winter'
        WHEN strftime('%m', date_day) IN ('03', '04', '05') THEN 'Spring'
        WHEN strftime('%m', date_day) IN ('06', '07', '08') THEN 'Summer'
        WHEN strftime('%m', date_day) IN ('09', '10', '11') THEN 'Autumn'
    END AS season
FROM date_range
ORDER BY date_day