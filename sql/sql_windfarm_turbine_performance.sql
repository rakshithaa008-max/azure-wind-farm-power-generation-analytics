
SELECT
    Turbine_ID,
    COUNT(*) AS hourly_readings,

    ROUND(
        SUM(TRY_CAST(Energy_Generated_MWh AS FLOAT)), 2
    ) AS total_energy_mwh,

    ROUND(
        AVG(TRY_CAST(Temperature_C AS FLOAT)), 2
    ) AS avg_temperature_c,

    ROUND(
        AVG(TRY_CAST(Vibration_mm_s AS FLOAT)), 2
    ) AS avg_vibration_mm_s,

    SUM(
        CASE WHEN Maintenance_Flag = 'REVIEW'
             THEN 1 ELSE 0 END
    ) AS review_records

FROM OPENROWSET(
    BULK 'https://stwindfarmdemo26.dfs.core.windows.net/bronze/wind_farm_telemetry.csv',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    HEADER_ROW = TRUE
) AS wind_data

GROUP BY Turbine_ID
ORDER BY total_energy_mwh DESC;
