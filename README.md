# Workforce Analytics - SQL Project (PostgreSQL)

**Primary Tools:** PostgreSQL  
**Data:** Synthetic / Anonymized  

---

## 1. Business Problem

Workforce and staffing teams require reliable, structured data to analyze recruitment funnel performance, hiring efficiency, and conversion effectiveness. Inconsistent data models and poor validation can lead to misleading insights and incorrect operational decisions.

This project simulates a real-world **recruitment lifecycle analytics** scenario with a strong focus on data integrity, funnel logic, and business-driven SQL analysis.

---

## 2. Objective

Build an end-to-end **workforce analytics data model and SQL analysis layer** to:

- Represent the full hiring lifecycle from job creation to hire  
- Ensure data quality and logical funnel progression  
- Analyze recruitment efficiency, conversion rates, and time-based performance  
- Answer operational and strategic workforce analytics questions  

---

## 3. Dataset Overview

- Fully synthetic dataset generated using PostgreSQL functions  
- Models a staffing workflow using the following tables:
  - clients
  - jobs
  - candidates
  - applications
  - stage_events
  - offers
- Designed to replicate realistic hiring volumes, drop-offs, and timelines  

---

## 4. KPIs & Metrics

- Application distribution across recruitment stages  
- Submission-to-Hire conversion rate  
- Stage-wise funnel drop-off counts  
- Average Time to Hire  
- Average time spent at each stage  
- Offer Acceptance Rate  
- Interview-to-Hire conversion rate  
- Client-wise hiring volume  
- Source-wise hire efficiency  
- Salary comparison between hired and non-hired candidates  

---

## 5. Approach & Tools

- Designed a **normalized relational schema** to model the recruitment lifecycle  
- Generated realistic synthetic data using `generate_series`, `random()`, and conditional logic  
- Enforced funnel sequencing using stage-event dependencies  
- Applied **data validation checks** to ensure analytical integrity  
- Used advanced SQL techniques including joins, window functions, CTEs, and conditional aggregation  

---

## 6. Key Insights (Illustrative)

- Significant drop-offs occur between Submission and Shortlist stages  
- Interview-to-Hire conversion highlights post-interview efficiency gaps  
- Certain sourcing channels consistently outperform others in hire efficiency  
- Hired candidates receive higher average offers compared to non-hired candidates  

---

## 7. Business Impact / Decisions Enabled

- Provides a reliable foundation for workforce and recruitment analytics  
- Enables identification of funnel bottlenecks and efficiency gaps  
- Supports optimization of sourcing strategies and hiring processes  
- Demonstrates how strong data validation improves trust in analytics outcomes  

---

## Project Structure

```text
01_table_creation.sql        --  Schema definition
02_data_insertion.sql        --  Synthetic data generation
03_data_validation.sql       --  Data quality & integrity checks
04_operations_analysis.sql   --  Business & operational insights```

---

## Author

**Ronit Kaushal**  
Data Analytics & Business Intelligence  

Email: ronitk95@gmail.com  
LinkedIn: https://www.linkedin.com/in/ronit-kaushal-a40609177/
