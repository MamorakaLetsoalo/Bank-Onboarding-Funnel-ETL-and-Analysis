# Bank-Onboarding-Funnel-ETL-and-Analysis

## 📌 Overview
This project delivers an end-to-end data engineering and analytics solution designed to help a bank understand and optimize its onboarding funnel, particularly for the unbanked market.

The solution tracks customer progression across onboarding steps, identifies drop-offs, and provides actionable insights through a Power BI dashboard.

---

## 🎯 Business Problem
Banks targeting the unbanked population often face high onboarding abandonment rates due to:
- Complex KYC processes
- Poor user experience across channels
- Limited visibility into customer journeys

This project solves that by:
- Tracking step-by-step onboarding behaviour
- Identifying where customers drop off
- Measuring channel performance
- Monitoring onboarding efficiency

---

## 🏗️ Architecture
CSV / Source Systems
↓
SSIS (ETL Pipeline)
↓
SQL Server (Data Warehouse - Star Schema)
↓
Analytics Layer (SQL Views + DAX)
↓
Power BI Dashboard


---

## 🧱 Data Model (Star Schema)

### ⭐ Fact Table
- `fact_onboarding_funnel`
  - customer_id
  - step_id
  - channel_id
  - step_sequence
  - drop_off_flag
  - completion_flag
  - time_spent_seconds

### 📊 Dimension Tables
- `dim_customer`
- `dim_channel`
- `dim_step`
- `dim_date`
- `dim_device`
- `dim_location`

<img width="800" height="621" alt="image" src="https://github.com/user-attachments/assets/9bbb532b-5754-4985-801d-3dbde48b8604" />


---

## 🔄 ETL Pipeline (SSIS)

### Control Flow
- Load CSV → RAW
- Transform RAW → STAGING
- Load DIMENSIONS
- Load FACT
- Logging & Error Handling
- 
<img width="563" height="624" alt="image" src="https://github.com/user-attachments/assets/2de9d49b-0a50-4aaf-b5c0-7bbdf675d445" />


- 

### Data Flow Transformations
- Data Conversion
- Derived Columns
- Conditional Split
- Lookup (Dimension Mapping)
- Error Redirection

<img width="391" height="580" alt="image" src="https://github.com/user-attachments/assets/796bbc17-952a-4ac0-8413-609f8db77492" />

---

## 📊 Analytics Layer

### SQL KPI Views
- Funnel performance
- Channel conversion
- Behaviour (time per step)

### DAX Measures
- Conversion Rate
- Drop-off Rate
- Step-to-step retention
- Average onboarding time
- Attempts per customer

### Dynamic KPI Selector
- Single measure powering multiple KPIs

---

## 📈 Power BI Dashboard

### Key Features
- Funnel visualization (step progression)
- KPI cards (conversion, drop-off)
- Channel performance analysis
- Time-based insights

---

## 📌 Key KPIs

| KPI | Description |
|-----|------------|
| Conversion Rate | % of users completing onboarding |
| Drop-off Rate | % of users exiting funnel |
| Step Conversion | Progression between steps |
| Avg Time per Step | User friction indicator |
| Channel Conversion | Channel effectiveness |

---

## 🧠 Key Learnings

- Designing scalable ETL pipelines using SSIS
- Implementing star schema for behavioural analytics
- Combining SQL and DAX for analytics modeling
- Building dynamic KPI frameworks in Power BI
- Applying funnel analysis to real-world banking scenarios

---

## 🚀 Future Enhancements

- Real-time streaming pipeline (Kafka / Event Hub)
- Machine learning model for drop-off prediction
- Cohort analysis for customer segmentation
- Incremental ETL (CDC)

---

## 🛠️ Tech Stack

- SQL Server (SSMS)
- SSIS (ETL)
- Power BI (Visualization)
- DAX (Analytics)

---

## 👤 Author
Letsoalo M

Data Analyst / Data Engineer focused on building scalable analytics solutions in financial services.
