# 📊 Sales Data Analysis & KPI Calculation

## 📌 Project Overview

This project showcases an end-to-end sales data analytics workflow using **Python and Pandas**. The objective is to transform raw transactional and dimensional data into a clean, analysis-ready dataset and derive key business KPIs that support data-driven decision-making.

The project closely follows real-world **Business Intelligence and data modeling practices**, making it suitable for analytics, BI, and Power BI-focused roles.

---

## 🗂️ Dataset Description

The project uses a **fact–dimension model**:

* **Fact Table**

  * `fact_sales.csv` – Transaction-level sales data

* **Dimension Tables**

  * `dim_customers.csv` – Customer demographics and regions
  * `dim_products.csv` – Product details and categories
  * `dim_dates.csv` – Calendar table for time-based analysis

---

## 🔄 Project Workflow

1. Imported required Python libraries (Pandas, NumPy)
2. Loaded fact and dimension datasets from CSV files
3. Inspected schemas, data types, and sample records
4. Mapped `DateID` from the sales table to actual calendar dates
5. Performed data type conversions for accurate analysis
6. Identified and handled missing values using business-driven rules
7. Merged all dimension tables with the fact table to create a denormalized dataset
8. Cleaned and standardized column names
9. Built an analytics-ready dataset for KPI calculation and BI usage

---

## 📈 Key KPIs Calculated

* **Total Revenue**
* **Total Quantity Sold**
* **Total Orders**
* **Average Discount Offered**

These KPIs provide a high-level view of sales performance and can be directly consumed by BI dashboards.

---

## 🛠️ Skills Demonstrated

* Python for Data Analysis (Pandas, NumPy)
* Data Cleaning & Preprocessing
* Handling Missing Values Strategically
* Fact & Dimension Data Modeling
* Dimensional Joins and Denormalization
* Date & Time Analysis using Calendar Tables
* KPI Development & Business Metrics
* BI-Ready Dataset Preparation
* Analytical and Business-Oriented Thinking

---

## 📊 Tools & Technologies

* **Programming Language:** Python
* **Libraries:** Pandas, NumPy
* **Data Format:** CSV
* **Analytics Use Case:** Sales Performance & KPI Analysis
* **BI Compatibility:** Power BI, Tableau, Excel

---

## 🚀 Future Enhancements

* Build interactive dashboards in **Power BI** using the prepared dataset
* Add time-based KPIs (MoM, QoQ, YoY growth)
* Perform product and regional performance analysis
* Automate the data pipeline for larger datasets

---

## 👤 Author

**Manish Vaity**
| Business Intelligence & Data Analytics Enthusiast

---

⭐ If you find this project useful, feel free to star the repository!
