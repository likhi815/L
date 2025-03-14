# Bank Analytics Project

## Overview
The **Bank Analytics Project** is designed to analyze loan data, revolving balances, and customer payment behaviors using **Excel, Power BI, and Tableau**. The project provides insights through various KPIs and dashboards to facilitate decision-making in the banking sector.

## Tools Used
- **Excel** (for basic data visualization and pivot analysis)
- **Power BI** (for interactive business intelligence dashboards)
- **Tableau** (for in-depth data visualization and analytics)
- **MySQL** (for data extraction and transformation using SQL queries)

## Key Performance Indicators (KPIs)
The project focuses on five major KPIs:

### **KPI 1: Year-wise Loan Amount Statistics**
- Total loan amounts issued per year.
- Maximum, minimum, and average loan amounts.
- SQL Query:
  ```sql
  SELECT
      YEAR(str_to_date(issue_d, '%d/%m/%Y')) as issue_year,
      Format(sum(loan_amnt),0) AS total_loan_amount,
      format(max(loan_amnt),0) AS max_loan_amount,
      format(min(loan_amnt),0) AS min_loan_amount,
      format(avg(loan_amnt),1) AS avg_loan_amount
  FROM bank
  GROUP BY YEAR(str_to_date(issue_d, '%d/%m/%Y'))
  ORDER BY issue_year;
  ```

### **KPI 2: Grade and Subgrade-wise Revolving Balance**
- Sum and average of revolving balances categorized by loan grades and sub-grades.
- SQL Query:
  ```sql
  SELECT grade, sub_grade,
  format(sum(revol_bal),0) AS Total_Revolving_Balance,
  format(avg(revol_bal),1) AS Average_Revolving_balance
  FROM bank
  GROUP BY grade, sub_grade
  ORDER BY grade;
  ```

### **KPI 3: Total Payment for Verified vs Non-Verified Customers**
- Comparison of total payments made by verified and non-verified customers.
- SQL Query:
  ```sql
  SELECT verification_status,
  format(sum(total_pymnt),0) AS Total_Payment
  FROM bank
  WHERE verification_status = "verified" OR verification_status = "not verified"
  GROUP BY verification_status;
  ```

### **KPI 4: State-wise and Month-wise Loan Status**
- Number of loans issued by state and by month.
- SQL Query:
  ```sql
  SELECT sn.state_name,
  DATE_FORMAT(STR_TO_DATE(b.issue_d, '%d/%m/%Y'), '%b') AS Month,
  COUNT(b.loan_status) AS loan_status_count
  FROM bank b
  JOIN state_names sn ON b.addr_state = sn.state_code
  GROUP BY sn.state_name, DATE_FORMAT(STR_TO_DATE(b.issue_d, '%d/%m/%Y'), '%b');
  ```

### **KPI 5: Home Ownership vs. Last Payment Date Analysis**
- Analysis of total payments and average time difference of last payment by homeownership type.
- SQL Query:
  ```sql
  ALTER TABLE bank ADD COLUMN time_difference INT;
  UPDATE bank  
  SET time_difference = -(DATEDIFF(STR_TO_DATE(issue_d, '%d/%m/%Y'), STR_TO_DATE(last_pymnt_d,'%d/%m/%Y')) / 30);
  
  SELECT home_ownership, format(sum(total_pymnt),0) AS total_payment,
  FORMAT(avg(total_pymnt),2) AS Average_total_payment, format(avg(time_difference),0) AS Time_difference
  FROM bank
  GROUP BY home_ownership;
  ```

## Dashboards & Visualizations

### **Excel Dashboard**
- Pie charts and bar graphs representing total payments vs verification status.
- Year-wise loan amounts and funded amounts.
- Grade-wise and subgrade-wise revolving balances.
- Filters for issue date and state.

### **Power BI Dashboard**
- Year-wise loan statistics with total, max, min, and average loan amounts.
- State-wise and month-wise loan status.
- Verified vs non-verified total payments.
- Homeownership analysis with last payment stats.

### **Tableau Dashboard**
- Heatmaps and bar charts for loan status by state and month.
- Grade-wise revolving balance with a comparative view.
- Loan statistics breakdown with detailed filters.

## Conclusion
This **Bank Analytics Project** provides deep insights into loan distribution, revolving balances, and customer payment trends. The combination of **SQL, Excel, Power BI, and Tableau** ensures comprehensive and dynamic analysis, aiding strategic decision-making in banking operations.

