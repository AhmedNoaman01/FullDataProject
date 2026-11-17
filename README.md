# 📊 Superstore Sales Analysis

An end-to-end data analysis project on Superstore sales data (2015–2018): data cleaning and EDA in **Python**, business queries in **SQL (PostgreSQL)**, and interactive dashboards in **Power BI** and **HTML**.

## 🎯 Project Goals

1. Understand the dataset
2. Clean the data with Python
3. Run exploratory data analysis (EDA)
4. Analyse the data with SQL
5. Prepare the data for a Power BI dashboard
6. Find actionable insights and recommendations
7. Write a final report

## 🛠️ Tools & Technologies

| Area | Tools |
|------|-------|
| Data cleaning & EDA | Python, pandas, NumPy, matplotlib, seaborn, Jupyter Notebook |
| Database & queries | PostgreSQL |
| Dashboard | Power BI, HTML + Chart.js |
| Reporting | PDF report |

## 📁 Repository Structure

```
DATAProject/
├── data/
│   └── train.csv                          # Raw dataset (9,800 rows, 18 columns)
├── cleaned_data/
│   ├── superstore_cleaned.csv             # Cleaned data (9,800 rows, 24 columns)
│   └── superstore_for_sql.csv             # Cleaned data formatted for PostgreSQL import
├── notebooks/
│   └── 01_Superstore_Sales_Analysis.ipynb # Cleaning + EDA notebook
├── sql/
│   ├── 01_create_table.sql                # Table schema and indexes
│   ├── 02_load_data.sql                   # Load the CSV into PostgreSQL
│   └── 03_analysis_queries.sql            # Analysis queries (KPIs, trends, rankings)
├── powerbi/
│   └── Dataproject.pbix                   # Power BI dashboard
└── reports/
    ├── Superstore_Sales_Analysis_Report.pdf
    └── Superstore Sales Dashboard.html    # Interactive HTML dashboard
```

## 🧹 Data Cleaning

- Filled **11 missing Postal Codes** (all Burlington, Vermont) with `05401`
- Converted date columns from text to proper date format
- Created new features: **Year, Month, Month Name, Quarter, Day of Week, Shipping Days**
- Checked for duplicates: no fully duplicate rows were found
- Result: **9,800 rows × 24 columns**, with no missing values

> **Note:** the dataset contains **Sales only**: there is no Quantity, Discount or Profit column, so profitability analysis is out of scope.

## 📈 Key Results

| Metric | Value |
|--------|-------|
| Total Sales | **$2,261,537** |
| Total Orders | 4,922 |
| Total Customers | 793 |
| Total Products | 1,861 |
| Average Order Value | $459.48 |

**Sales by year**

| Year | Sales | Change |
|------|-------|--------|
| 2015 | $479,856 | – |
| 2016 | $459,436 | −4.3% |
| 2017 | $600,193 | +30.6% |
| 2018 | $722,052 | +20.3% |

**Other highlights**

- **Region:** West (31.4%) › East (29.6%) › Central (21.8%) › South (17.2%)
- **Top state:** California, $446,306 (almost 20% of all sales), followed by New York and Texas
- **Segment:** Consumer 50.8% · Corporate 30.4% · Home Office 18.8%
- **Category:** Technology 36.6% · Furniture 32.2% · Office Supplies 31.2%
- **Top sub-categories:** Phones, Chairs, Storage, Tables, Binders
- **Seasonality:** November and December are the strongest months; Q4 is the best quarter every year
- **Shipping:** Standard Class is the most used (about 5 days on average)

## 💡 Insights & Recommendations

1. **Strong growth since 2017.** Find out what drove it (marketing, products, operations) and double down.
2. **Heavy reliance on the West and California.** Build targeted plans for the East, Central and South to reduce concentration risk.
3. **Consumer segment brings over half of sales.** Keep it loyal, and create offers to grow Corporate and Home Office.
4. **Phones and Chairs lead.** Keep them in stock and well priced; bundle them with related products to raise order value.
5. **November–December peak.** Plan stock, staff and marketing early and start promotions in September/October.
6. **Standard Class dominates shipping.** Consider promoting faster options for larger orders and monitor delivery times by region.

## 🚀 How to Run

### 1. Notebook
```bash
pip install pandas numpy matplotlib seaborn jupyter
jupyter notebook notebooks/01_Superstore_Sales_Analysis.ipynb
```
The notebook reads the data from `../data/train.csv`, so run it from inside the `notebooks/` folder.

### 2. SQL (PostgreSQL)
```bash
psql -d your_database -f sql/01_create_table.sql
psql -d your_database -f sql/02_load_data.sql
psql -d your_database -f sql/03_analysis_queries.sql
```
⚠️ In `sql/02_load_data.sql`, change the file path in the `\copy` command to the location of `cleaned_data/superstore_for_sql.csv` on your machine.

### 3. Dashboards
- **Power BI:** open `powerbi/Dataproject.pbix` in Power BI Desktop.
- **HTML:** open `reports/Superstore Sales Dashboard.html` in any browser (needs an internet connection to load Chart.js).

## 📄 Full Report

See [`reports/Superstore_Sales_Analysis_Report.pdf`](reports/Superstore_Sales_Analysis_Report.pdf) for the complete write-up.

## 👤 Author

**Ahmed**: Junior Data Analyst
