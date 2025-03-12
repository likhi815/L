-- KPI1
SELECT 
    YEAR(str_to_date(issue_d, '%d/%m/%Y')) as issue_year,
    Format(sum(loan_amnt),0) AS total_loan_amount,
    format(max(loan_amnt),0) AS max_loan_amount,
    format(min(loan_amnt),0) AS min_loan_amount,
    format(avg(loan_amnt),1) AS avg_loan_amount
From bank
group by YEAR(str_to_date(issue_d, '%d/%m/%Y'))
order by issue_year;

-- KPI 2
select grade , sub_grade,
format(sum(revol_bal),0)as Total_Revolving_Balance,
format(avg(revol_bal),1) as Average_Revolving_balance
from bank
group by grade,sub_grade
order by grade;

-- KPI 3
select 
verification_status,
format(sum(total_pymnt),0) as Total_Payment
from bank
where verification_status = "verified" or verification_status = "not verified"
group by verification_status;

-- KPI 4
SELECT 
  sn.state_name,
  DATE_FORMAT(STR_TO_DATE(b.issue_d, '%d/%m/%Y'), '%b') AS Month, 
  COUNT(CASE WHEN b.loan_status = 'charged off' THEN 1 END) AS charged_off,
  COUNT(CASE WHEN b.loan_status = 'current' THEN 1 END) AS current,
  COUNT(CASE WHEN b.loan_status = 'fully paid' THEN 1 END) AS fully_paid
FROM 
  bank b
JOIN 
  state_names sn ON b.addr_state = sn.state_code
GROUP BY 
  sn.state_name, DATE_FORMAT(STR_TO_DATE(b.issue_d, '%d/%m/%Y'), '%b')
  order by sn.state_name,Month;

 
 -- KPI 5
 
 alter table bank  add column time_difference int;
 update bank  
 set time_difference = -(DATEDIFF(str_to_date(issue_d, '%d/%m/%Y'), STR_TO_DATE(last_pymnt_d,'%d/%m/%Y')) / 30);

select home_ownership, format(sum(total_pymnt),0) as total_payment, 
Format(avg(total_pymnt),2) as Average_total_payment, format(avg(time_difference),0) as Time_difference from bank 
 group by home_ownership;

  
  



