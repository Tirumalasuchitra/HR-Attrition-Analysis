CREATE DATABASE HRAnalytics;
USE HRAnalytics;

CREATE TABLE employee_attrition (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(30),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/WA_Fn-UseC_-HR-Employee-Attrition.csv' 
INTO TABLE employee_attrition 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW tables;

DESCRIBE employee_attrition;
select * from employee_attrition limit 10;

select count(*) from employee_attrition;

-- attrition rate by overtime, 1. Which factors most influence employee attrition? 

select OverTime, count(*) as total_employees, 
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) as attrition_count,
  
(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) *100)/count(*) as attrition_rate
from employee_attrition 
group by OverTime;

-- attrition rate by Jobsatisfaction

select JobSatisfaction, count(*) as total_employees, 
count(case when attrition ='yes' then 1 end) as attrition_count,
(count(case when attrition = 'yes' then 1 end)*100)/count(*) as  attrition_rate

from employee_attrition
group by JobSatisfaction
order by attrition_rate DESC;

-- attrition rate by montly income
select  
case when MonthlyIncome < 5000 then 'low'
     when   MonthlyIncome  between 5000 and 10000   then 'medium'
		when  MonthlyIncome >10000	  then 'high'
         end  as income_bucket,
        count(*) as total_employees, 
count(case when attrition = 'yes' then 1 END) as attrition_count,
(count(case when attrition = 'yes' then 1 end)*100.0)/count(*) as attrition_rate
from employee_attrition
group by income_bucket
order by attrition_rate DESC;

-- Attrition rate by YearsAtCompany(Tenure buckets)
select 
case when YearsAtCompany between 0 and  2  then 'short Tenure'
     when YearsAtCompany between 3 and 5  then 'medium Tenure'
     when YearsAtCompany between  6 and 10  then 'long Tenure'
     when YearsAtCompany > 10  then 'very long' END as tenure_bucket, 
     count(*) as total_employees ,
     count(case when attrition = 'Yes' then 1 end) as attrition_count,
     (count(Case when attrition = 'Yes' then 1 end)*100.0)/count(*) as attrition_rate
	from employee_attrition
    group by tenure_bucket
    order by attrition_rate DESC;
-- adding department to the above
select  Department,
case when YearsAtCompany between 0 and  2  then 'short Tenure'
     when YearsAtCompany between 3 and 5  then 'medium Tenure'
     when YearsAtCompany between  6 and 10  then 'long Tenure'
     when YearsAtCompany > 10  then 'very long' END as tenure_bucket, 
     count(*) as total_employees ,
     count(case when attrition = 'yes' then 1 end) as attrition_count,
     (count(Case when attrition = 'yes' then 1 end)*100.0)/count(*) as attrition_rate
	from employee_attrition
    group by tenure_bucket ,  Department
    order by Department ,  attrition_rate DESC;
    
    -- Attrition Rate by OverTime AND JobSatisfaction , Are employees with low satisfaction + overtime the worst group?
    select OverTime , JobSatisfaction, count(*) as total_employees,
    count(case when attrition= 'Yes' then 1 end) as attrition_count,
    (count(case when attrition = 'Yes' then 1 end)*100.0)/count(*) as attrition_rate
   
    from employee_attrition
    group by OverTime , JobSatisfaction
    order by OverTime , JobSatisfaction;
  
  -- Employees working overtime show higher attrition (~30%) compared to the overall population. Employees with low job satisfaction also exhibit elevated attrition (~22%). 
-- However, the highest attrition (~35–37%) is observed among employees who both work overtime and report low job satisfaction, indicating that workload pressure combined with dissatisfaction significantly increases the likelihood of employee turnover. 
-- Attrition Rate by JobRole
select JobRole, count(*) as total_employees, 
count(case when attrition = 'Yes' then 1 end) as attrition_count,
(count(case when attrition = 'Yes' then 1 end) *100.0)/count(*) as attrition_rate
from employee_attrition
group by JobRole
order by attrition_rate DESC;

-- Monthly Income Bucket vs Job Role

select JobRole, count(*) as total_employees, 
count(case when attrition ='Yes' then 1 end) as attrition_count,
(count(case when attrition = 'yes' then 1 end) * 100.0)/count(*) as attrition_rate,
case when MonthlyIncome < 5000 then 'low'
     when   MonthlyIncome  between 5000 and 10000   then 'medium'
		when  MonthlyIncome >10000	  then 'high'
         end  as income_bucket
from employee_attrition

group by JobRole, income_bucket
HAVING COUNT(*) > 30
order by attrition_rate DESC;


    