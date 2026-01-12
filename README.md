# Credit Card Transactions Analysis using SQL Server

## 📌 Project Overview
This project focuses on analyzing large-scale credit card transaction data using **Microsoft SQL Server**.  
The objective is to derive meaningful business insights related to spending behavior, city-wise trends, card usage patterns, and transaction growth using **advanced SQL queries and stored procedures**.

The project is designed to simulate **real-world analytics scenarios** commonly handled by data analysts and BI developers.

---

## 🗂 Dataset Description
The dataset contains credit card transaction records with attributes such as:
- Transaction Date
- City
- Card Type
- Expense Type
- Gender
- Amount Spent

---

## 🎯 Key Business Questions Addressed
- Identify top cities contributing to overall credit card spending
- Analyze month-wise and card-type-wise spending trends
- Track cumulative spend milestones by card type
- Compare expense patterns across cities and demographics
- Measure month-over-month growth in spending
- Analyze transaction efficiency during weekends
- Identify transaction velocity across cities

---

## 🛠️ Technical Implementation

### 🔹 SQL Query-Based Analysis
Implemented complex SQL queries using:
- Aggregate functions (`SUM`, `COUNT`, `AVG`)
- Window functions (`RANK`, `ROW_NUMBER`, `SUM OVER`)
- Date functions
- Conditional logic
- Percentage contribution analysis

Key analyses include:
- Top 5 cities by spend and contribution percentage
- Highest spend month per card type
- City-wise expense dominance (highest & lowest)
- Gender-based spend contribution
- Weekend spend efficiency analysis

---

### 🔹 Stored Procedure-Based Analysis
Developed **parameterized stored procedures** to enable reusable, secure, and production-ready analytics:
- Fetch top transactions for a selected city
- Monthly spend trend for a card type and year
- Amount-range-based transaction analysis with output parameters
- City-wise contribution for selected expense types

Additional features:
- Input validation
- Optimized performance
- Reusability for Power BI integration
- Audit-friendly design

---

## 📊 Use Cases
- Backend data source for **Power BI dashboards**
- SQL interview and assessment preparation
- Learning advanced SQL analytics patterns
- Demonstrating production-grade SQL development

---

## 🚀 Skills Demonstrated
- Advanced SQL querying
- Window functions & analytical SQL
- Stored procedure design
- Performance-aware SQL development
- Business-oriented data analysis
- SQL Server analytics for BI reporting

---

## 🧠 Tools & Technologies
- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)

---

## 📈 Future Enhancements
- Integrate with Power BI for interactive dashboards
- Add indexing and execution plan optimization
- Implement logging tables for stored procedure execution
- Extend analysis to year-over-year trends

---

## 📬 Author
**Manish Vaity**  
BI Developer | SQL | Power BI | Data Analytics

---

⭐ If you found this project useful, feel free to star the repository!
