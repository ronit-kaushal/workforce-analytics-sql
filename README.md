# 📊 Workforce Analytics — SQL Project (PostgreSQL)

## Overview
This project demonstrates an end-to-end **Workforce Analytics data model and analysis** built using **PostgreSQL**.  
It simulates a real-world recruitment lifecycle — from job creation to hiring — using **synthetic but realistic data**.

The focus of this project is on:
- Data modeling
- Data quality validation
- Operational and business analytics using SQL

---

## Dataset & Schema
The database models a typical staffing workflow using the following tables:

- **clients** — client companies and industries  
- **jobs** — job openings created by clients  
- **candidates** — candidate profiles and sourcing channels  
- **applications** — job applications with final stage status  
- **stage_events** — stage-level timeline (submission → hire)  
- **offers** — offer details and acceptance status  

All data is **synthetically generated** using PostgreSQL functions (`generate_series`, `random`) while preserving realistic business logic and constraints.

---

## Project Structure

```text
01_table_creation.sql      -- Schema definition
02_data_insertion.sql     -- Synthetic data generation
03_data_validation.sql    -- Data quality & integrity checks
04_operations_analysis.sql-- Business & operational insights

Each script is designed to be executed sequentially to fully recreate the dataset and analysis.
