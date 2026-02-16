# AtlasMart End-to-End Data Analytics Project

## Project Overview

This project delivers a full end-to-end analysis of AtlasMart’s sales performance using transactional retail data. The objective was to uncover revenue opportunities, profitability drivers, operational inefficiencies, and customer value patterns to support data-driven business decisions.

The analysis workflow covered data cleaning, SQL exploratory analysis, dimensional modeling, visualization, and executive-level insight generation.

---

## Tools Used

- Excel (Power Query) – Data cleaning and preparation  
- SQL Server – Exploratory Data Analysis  
- Power BI – Data modeling and dashboard visualization  
- GitHub – Project version control  

---

## Dataset

Retail transactional dataset containing:

- Orders  
- Products  
- Customers  
- Sales, Profit, Discounts  
- Shipping details  

Located in:
data/superstore.csv

---

## Project Workflow

### 1. Data Cleaning (Excel / Power Query)

- Removed irrelevant fields  
- Handled missing values  
- Fixed data types  
- Normalized tables (Orders, Products, Customers)  
- Removed duplicates  

---

### 2. SQL Exploratory Data Analysis

Key analysis areas:

- Revenue trends (monthly / yearly)
- Product performance
- Profitability by segment and category
- Discount impact on margins
- Customer profitability distribution

SQL scripts available in:
sql/AtlasMart.sql

---

### 3. Data Visualization (Power BI)

A two-page executive dashboard was built:

### Page 1 — Revenue Performance Overview

KPIs:
- Total Revenue
- Total Customers
- Average Order Value

Visuals:
- Monthly revenue trend  
- Revenue by parameter (Region / Segment / Category)  
- Top & bottom products  
- Profit margin by segment  

---

### Page 2 — Profit Drivers & Risk Diagnostics

KPIs:
- Profit Margin  
- Average Discount  

Visuals:
- Customer profit distribution  
- Profit vs discount bands  
- Shipping performance  
- Profit by parameter  

Dashboard file:
dashboard/AtlasMart_Report.pbix

Preview image:
images/dashboard_preview.png

---

## Business Insights (Based on 2018)

- Revenue peaked in November and declined sharply in February.  
- Technology led category performance while South region lagged.  
- Deep discounts (>30%) resulted in negative margins.  
- Most customers fall into low-profit or loss-making bands.  
- Faster shipping did not improve profitability.  

---

## Strategic Recommendations

- Focus inventory and sales on high-performing products.
- Strengthen South region demand generation.
- Implement discount controls above 20%.
- Move low-profit customers into higher-value tiers.
- Reassess pricing and fulfillment policies for loss-making customers.

---

## Documentation

Full project documentation is available in:
documentation/Documentary.docx


---

## Author

Ambali Mustapha  
Data Analyst (Financial & Business Analytics Focus)

---




