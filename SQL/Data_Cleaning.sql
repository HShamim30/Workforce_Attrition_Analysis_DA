--1 Creating Backup Table
CREATE TABLE employees_backup AS
SELECT *
FROM employees;

--2. Remove leading
UPDATE employees
SET
    department = NULLIF(BTRIM(department), ''),
    educationfield = NULLIF(BTRIM(educationfield), ''),
    gender = NULLIF(BTRIM(gender), ''),
    jobrole = NULLIF(BTRIM(jobrole), ''),
    maritalstatus = NULLIF(BTRIM(maritalstatus), ''),
    overtime = NULLIF(BTRIM(overtime), '');

--3. Standardize overtime values
UPDATE employees
SET overtime =
    CASE
        WHEN LOWER(BTRIM(overtime)) = 'yes' THEN 'Yes'
        WHEN LOWER(BTRIM(overtime)) = 'no' THEN 'No'
        ELSE overtime
    END;

SELECT overtime, COUNT(*) AS employee_count
FROM employees
GROUP BY overtime;

--4. Standardize Department

UPDATE employees
SET department =
    CASE
        WHEN LOWER(BTRIM(department)) = 'sales'
            THEN 'Sales'
        WHEN LOWER(BTRIM(department)) = 'research & development'
            THEN 'Research & Development'
        WHEN LOWER(BTRIM(department)) = 'human resources'
            THEN 'Human Resources'
        ELSE BTRIM(department)
    END;

SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY department;

--5. Standardize Gender
UPDATE employees
SET gender =
    CASE
        WHEN LOWER(BTRIM(gender)) = 'male' THEN 'Male'
        WHEN LOWER(BTRIM(gender)) = 'female' THEN 'Female'
        ELSE BTRIM(gender)
    END;

--6. Standardize Buisness Travel
UPDATE employees
SET businesstravel =
    CASE
        WHEN LOWER(BTRIM(businesstravel)) = 'travel_rarely'
            THEN 'Travel_Rarely'
        WHEN LOWER(BTRIM(businesstravel)) = 'travel_frequently'
            THEN 'Travel_Frequently'
        WHEN LOWER(BTRIM(businesstravel)) = 'non-travel'
          OR LOWER(BTRIM(businesstravel)) = 'non_travel'
            THEN 'Non-Travel'
        ELSE BTRIM(businesstravel)
    END;

SELECT businesstravel, COUNT(*) AS employee_count
FROM employees
GROUP BY businesstravel
ORDER BY businesstravel;

--7. Check invalid numeric values
SELECT *
FROM employees
WHERE age < 18
   OR age > 100
   OR monthlyincome <= 0
   OR distancefromhome < 0
   OR totalworkingyears < 0
   OR yearsatcompany < 0
   OR yearsincurrentrole < 0
   OR yearssincelastpromotion < 0
   OR yearswithcurrmanager < 0;

--8. Check satisfaction ratings
SELECT *
FROM employees
WHERE jobsatisfaction NOT BETWEEN 1 AND 4
   OR environmentsatisfaction NOT BETWEEN 1 AND 4
   OR relationshipsatisfaction NOT BETWEEN 1 AND 4
   OR worklifebalance NOT BETWEEN 1 AND 4
   OR jobinvolvement NOT BETWEEN 1 AND 4;

--9. check duplicates candidates

SELECT
    age,
    attrition,
    department,
    jobrole,
    monthlyincome,
    yearsatcompany,
    COUNT(*) AS matchingrecords
FROM employees
GROUP BY
    age,
    attrition,
    department,
    jobrole,
    monthlyincome,
    yearsatcompany
HAVING COUNT(*) > 1
ORDER BY matchingrecords DESC;

--10 . Final cleaning verification
SELECT
    COUNT(*) AS total_records,
    COUNT(*) - COUNT(attrition) AS missing_attrition,
    COUNT(*) - COUNT(department) AS missing_department,
    COUNT(*) - COUNT(jobrole) AS missing_job_role,
    COUNT(*) - COUNT(monthlyincome) AS missing_income
FROM employees;

SELECT attrition, COUNT(*) AS employee_count
FROM employees
GROUP BY attrition;

SELECT overtime, COUNT(*) AS employee_count
FROM employees
GROUP BY overtime;
