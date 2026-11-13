SELECT
    COUNT(*) AS total_records,

    COUNT(DISTINCT Turbine_ID) AS total_turbines,

    ROUND(
        SUM(TRY_CAST(Energy_Generated_MWh AS FLOAT)),
        2
    ) AS total_energy_mwh,

    SUM(
        CASE
            WHEN Maintenance_Flag = 'REVIEW'
            THEN 1
            ELSE 0
        END
    ) AS maintenance_review_records

FROM OPENROWSET(
    BULK 'https://stwindfarmdemo26.dfs.core.windows.net/bronze/wind_farm_telemetry.csv',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    HEADER_ROW = TRUE
) AS wind_data;
