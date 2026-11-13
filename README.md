# Azure Wind Farm Power Generation & Turbine Health Analytics

## Project Overview

An end-to-end Azure Data Engineering and Power BI portfolio project using synthetic wind turbine telemetry data to analyse renewable energy generation, turbine performance, temperature, vibration and maintenance-review indicators.

## Technologies Used

- Azure Data Lake Storage Gen2 (ADLS)
- Azure Data Factory (ADF)
- Azure Synapse Analytics — Serverless SQL
- SQL
- Microsoft Power BI Service
- Power Query
- Microsoft Excel

## Implemented Azure Data Architecture

**Synthetic Wind Turbine CSV → ADLS Gen2 (Landing) → Azure Data Factory (Copy Data Pipeline) → ADLS Gen2 (Bronze) → Azure Synapse Serverless SQL → Energy & Turbine Health Analytics**

### 1. Data Source

Used synthetic wind turbine telemetry data representing 10 wind turbines, with 1,680 records covering power output, energy generation, wind speed, temperature, vibration and maintenance-review indicators.

Source file: `wind_farm_telemetry.csv`

### 2. Azure Data Lake Storage Gen2

Created storage account `stwindfarmdemo26` with two containers:

- `landing` — stores the uploaded source CSV file.
- `bronze` — stores the CSV copied by the ingestion pipeline.

### 3. Azure Data Factory

Created and executed the pipeline `pl_windfarm_ingestion`.

The `Copy_landing_to_bronze` activity copies the telemetry CSV from the Landing container into the Bronze container.

The pipeline run succeeded, and the destination file was verified in Azure Storage.

### 4. Azure Synapse Serverless SQL

Used the Synapse workspace `syn-windfarm-demo26` and its built-in serverless SQL pool.

Queried the Bronze CSV directly using SQL `OPENROWSET`, without creating a dedicated SQL pool.

Implemented two SQL analytics scripts:

- `sql_windfarm_energy_kpis.sql` — overall energy and maintenance KPIs.
- `sql_windfarm_turbine_performance.sql` — turbine-level energy, temperature, vibration and maintenance analysis.

## Verified Project Results

| Metric | Result |
|---|---:|
| Telemetry records | 1,680 |
| Wind turbines | 10 |
| Total energy generated | 1,257.91 MWh |
| Maintenance-review records | 29 |

These results were verified using Azure Synapse Serverless SQL on synthetic demonstration data.

## Power BI Dashboards

Created a two-page Power BI report:

**Page 1 — Power Generation Analytics**

- Total energy generated
- Energy generation trends
- Energy generation by turbine

**Page 2 — Turbine Health Analytics**

- Average temperature by turbine
- Average vibration by turbine
- Maintenance-review indicators

**Current integration status:** The Power BI report uses the synthetic Excel dataset through Power Query and a Power BI semantic model. The Azure Synapse SQL analysis is implemented separately; a direct Synapse-to-Power-BI data connection has not yet been configured.

## Repository Structure

- `adf/pl_windfarm_ingestion.json` — Azure Data Factory pipeline definition
- `sql/sql_windfarm_energy_kpis.sql` — energy KPI queries
- `sql/sql_windfarm_turbine_performance.sql` — turbine performance queries
- `power_generation_dashboard.png` — Power BI generation dashboard
- `turbine_health_dashboard.png` — Power BI turbine health dashboard
- `wind_farm_powerbi_starter.xlsx` — synthetic source workbook
- `README.md` — project documentation

