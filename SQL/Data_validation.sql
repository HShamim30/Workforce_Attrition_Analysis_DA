--1.Total number of records
SELECT COUNT(*) AS total_employees
FROM employees;

--2.Viewing TOP 10 Records
SELECT *
FROM Employees
LIMIT 10;

--3.Checking column Name
SELECT 
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'employees'
ORDER BY ordinal_position;

--4.Checking If any NULL value is there 
SELECT
    COUNT(*) - COUNT(age) AS age_nulls,
    COUNT(*) - COUNT(attrition) AS attrition_nulls,
    COUNT(*) - COUNT(dailyrate) AS daily_rate_nulls,
    COUNT(*) - COUNT(department) AS department_nulls,
    COUNT(*) - COUNT(distancefromhome) AS distance_nulls,
    COUNT(*) - COUNT(education) AS education_nulls,
    COUNT(*) - COUNT(educationfield) AS education_field_nulls,
    COUNT(*) - COUNT(environmentsatisfaction) AS environment_satisfaction_nulls,
    COUNT(*) - COUNT(gender) AS gender_nulls,
    COUNT(*) - COUNT(hourlyrate) AS hourly_rate_nulls,
    COUNT(*) - COUNT(jobinvolvement) AS job_involvement_nulls,
    COUNT(*) - COUNT(joblevel) AS job_level_nulls,
    COUNT(*) - COUNT(jobrole) AS job_role_nulls,
    COUNT(*) - COUNT(jobsatisfaction) AS job_satisfaction_nulls,
    COUNT(*) - COUNT(maritalstatus) AS marital_status_nulls,
    COUNT(*) - COUNT(monthlyincome) AS monthly_income_nulls,
    COUNT(*) - COUNT(monthlyrate) AS monthly_rate_nulls,
    COUNT(*) - COUNT(numcompaniesworked) AS companies_worked_nulls,
    COUNT(*) - COUNT(overtime) AS overtime_nulls,
    COUNT(*) - COUNT(percentsalaryhike) AS salary_hike_nulls,
    COUNT(*) - COUNT(performancerating) AS performance_rating_nulls,
    COUNT(*) - COUNT(relationshipsatisfaction) AS relationship_satisfaction_nulls,
    COUNT(*) - COUNT(stockoptionlevel) AS stock_option_nulls,
    COUNT(*) - COUNT(totalworkingyears) AS total_working_years_nulls,
    COUNT(*) - COUNT(trainingtimeslastyear) AS training_nulls,
    COUNT(*) - COUNT(worklifebalance) AS work_life_balance_nulls,
    COUNT(*) - COUNT(yearsatcompany) AS years_at_company_nulls,
    COUNT(*) - COUNT(yearsincurrentrole) AS current_role_years_nulls,
    COUNT(*) - COUNT(yearssincelastpromotion) AS promotion_years_nulls,
    COUNT(*) - COUNT(yearswithcurrmanager) AS manager_years_nulls
FROM employees;

--5. Checking Attribute Value
SELECT
    attrition,
    COUNT(*) AS employee_count
FROM employees
GROUP BY attrition
ORDER BY employee_count DESC;

--6. Checking Department Values
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC;

--7. Check Job Role values
SELECT
    jobrole,
    COUNT(*) AS employee_count
FROM employees
GROUP BY jobrole
ORDER BY employee_count DESC;

--8.Check Gender values
SELECT
    gender,
    COUNT(*) AS employee_count
FROM employees
GROUP BY gender;

--9.Check Overtime values
SELECT
    overtime,
    COUNT(*) AS employee_count
FROM employees
GROUP BY overtime;

--10. Check duplicate records
SELECT
    age,
    department,
    jobrole,
    monthlyincome,
    yearsatcompany,
    COUNT(*) AS duplicate_count
FROM employees
GROUP BY
    age,
    department,
    jobrole,
    monthlyincome,
    yearsatcompany
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;
Check Gender values
SELECT
    gender,
    COUNT(*) AS employee_count
FROM employees
GROUP BY gender;

--11. Check Overtime values
SELECT
    overtime,
    COUNT(*) AS employee_count
FROM employees
GROUP BY overtime;
--12. Check Age range
SELECT
    MIN(age) AS minimum_age,
    MAX(age) AS maximum_age,
    AVG(age) AS average_age
FROM employees;

--13. Find invalid ages
SELECT *
FROM employees
WHERE age < 18
   OR age > 70;

--14. Check Monthly Income
SELECT
    MIN(monthlyincome) AS minimumincome,
    MAX(monthlyincome) AS maximumincome,
    ROUND(AVG(monthlyincome), 2) AS averageincome
FROM employees;

--15. Check invalid income
SELECT *
FROM employees
WHERE monthlyincome <= 0;

--16. Check Years at Company
SELECT
    MIN(yearsatcompany) AS minimumyears,
    MAX(yearsatcompany) AS maximumyears,
    ROUND(AVG(yearsatcompany), 2) AS averageyears
FROM employees;

--17. Check impossible tenure values
SELECT *
FROM employees
WHERE yearsatcompany < 0
   OR yearsincurrentrole < 0
   OR yearssincelastpromotion < 0
   OR yearswithcurrmanager < 0;

--18. Check satisfaction ratings
SELECT
    MIN(jobsatisfaction) AS minjobsatisfaction,
    MAX(jobsatisfaction) AS maxjobsatisfaction,
    MIN(environmentsatisfaction) AS minenvironmentsatisfaction,
    MAX(environmentsatisfaction) AS maxenvironmentsatisfaction,
    MIN(relationshipsatisfaction) AS minrelationshipsatisfaction,
    MAX(relationshipsatisfaction) AS maxrelationshipsatisfaction
FROM employees;


--19. Find invalid satisfaction values
SELECT *
FROM employees
WHERE jobsatisfaction NOT BETWEEN 1 AND 4
   OR environmentsatisfaction NOT BETWEEN 1 AND 4
   OR relationshipsatisfaction NOT BETWEEN 1 AND 4;

--20.Check Job Level
SELECT
    joblevel,
    COUNT(*) AS employee_count
FROM employees
GROUP BY joblevel
ORDER BY joblevel;

--21. Check Performance Rating
SELECT
    performancerating,
    COUNT(*) AS employee_count
FROM employees
GROUP BY performancerating
ORDER BY performancerating;

--22. Check Education values
SELECT
    education,
    COUNT(*) AS employee_count
FROM employees
GROUP BY education
ORDER BY education;

--23. Check Work-Life Balance
SELECT
    work_life_balance,
    COUNT(*) AS employee_count
FROM employees
GROUP BY worklifebalance
ORDER BY worklifebalance;

--24.Overall Data Quality Summary
SELECT
    COUNT(*) AS total_records,
    COUNT(age) AS valid_age_records,
    COUNT(attrition) AS valid_attrition_records,
    COUNT(department) AS valid_department_records,
    COUNT(jobrole) AS valid_job_role_records,
    COUNT(monthlyincome) AS valid_income_records,
    COUNT(overtime) AS valid_overtime_records
FROM employees;