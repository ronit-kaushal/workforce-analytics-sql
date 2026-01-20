# Workforce Analytics - SQL Project (PostgreSQL)

## Overview
This project demonstrates an end-to-end **Workforce Analytics data model and analysis** built using **PostgreSQL**.  
It simulates a real-world recruitment lifecycle - from job creation to hiring - using **synthetic but realistic data**.

The focus of this project is on:
- Data modeling
- Data quality validation
- Operational and business analytics using SQL

---

## Dataset & Schema
The database models a typical staffing workflow using the following tables:

- **clients** - client companies and industries  
- **jobs** - job openings created by clients  
- **candidates** - candidate profiles and sourcing channels  
- **applications** - job applications with final stage status  
- **stage_events** - stage-level timeline (submission → hire)  
- **offers** - offer details and acceptance status  

All data is **synthetically generated** using PostgreSQL functions (`generate_series`, `random`) while preserving realistic business logic and constraints.

---

## Project Structure

```text
01_table_creation.sql        -- Schema definition
02_data_insertion.sql        -- Synthetic data generation
03_data_validation.sql       -- Data quality & integrity checks
04_operations_analysis.sql   -- Business & operational insights
```

Each script is designed to be executed sequentially to fully recreate the dataset and analysis.

---

## Synthetic Data Generation
All data in this project is generated using native **PostgreSQL functions** to closely simulate real-world recruitment workflows.

Key techniques used:
- `generate_series` for controlled data volumes
- `random()` for realistic variability
- Conditional logic to enforce funnel behavior

The data generation logic ensures:
- Logical stage progression (e.g., Interview cannot occur without Shortlist)
- Realistic drop-offs across funnel stages
- Offers exist only for valid application stages (Offer or Hire)
- All hired candidates have accepted offers

This approach balances realism with simplicity, making the dataset suitable for analytical exploration without unnecessary complexity.

---

## Data Validation
Before performing any analysis, multiple validation checks are applied to ensure **data quality and consistency**, including:

- Every application has exactly one Submission event  
- Interview stages cannot exist without prior Shortlisting  
- Offers exist only for Offer or Hire stages  
- All hired applications have accepted offers  
- Funnel stage counts follow a logical progression  

These checks ensure that analytical insights derived from the dataset are **reliable, consistent, and trustworthy**.

---

## Operational & Business Questions Answered
The analysis addresses key operational and strategic questions, including:

- Application distribution across final funnel stages  
- Overall submission-to-hire conversion rate  
- Stage-wise funnel drop-off counts  
- Average time to hire  
- Average time spent at each stage  
- Offer acceptance rate  
- Salary comparison between hired and non-hired candidates  
- Client-wise hiring volume  
- Source-wise hire efficiency  
- Interview-to-hire conversion effectiveness  

Each query is written with **clarity, correctness, and business relevance**, mirroring real-world workforce analytics use cases.

---

## Tools & SQL Concepts Used
- **Database:** PostgreSQL  

**Key SQL concepts applied:**
- Joins
- Window functions
- Conditional aggregation
- Common Table Expressions (CTEs)
- Data validation and integrity checks

---

## Notes
- All data used in this project is **synthetic** and created solely for learning and portfolio demonstration.
- No proprietary, confidential, or real-world datasets are used.
- The project is fully reproducible by executing the SQL scripts in sequential order.

---

## Author

**Ronit Kaushal**  
Data Analytics & Business Intelligence  

Email: ronitk95@gmail.com  
LinkedIn: https://www.linkedin.com/in/ronit-kaushal-a40609177/
