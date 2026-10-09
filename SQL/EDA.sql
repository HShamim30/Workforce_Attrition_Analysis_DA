--1. What is the overall employee attrition rate?
SELECT
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    COUNT(*) FILTER (WHERE attrition = 0) AS employees_retained,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees;


--2. Which department has the highest attrition rate?
SELECT
    department,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY department
ORDER BY attrition_rate_percentage DESC;

--3. Which job role has the highest attrition rate?
SELECT
    jobrole,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY jobrole
ORDER BY attrition_rate_percentage DESC;


--4. How does overtime relate to employee attrition?
SELECT
    overtime,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY overtime
ORDER BY attrition_rate_percentage DESC;

--5.How does business travel relate to employee attrition?
SELECT
    businesstravel,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY businesstravel
ORDER BY attrition_rate_percentage DESC;

--6. Which age group has the highest attrition rate?
SELECT
    CASE
        WHEN age <= 25 THEN '18-25'
        WHEN age <= 35 THEN '26-35'
        WHEN age <= 45 THEN '36-45'
        WHEN age <= 55 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY 1
ORDER BY attrition_rate_percentage DESC;

--7. Which tenure group has the highest attrition rate?
SELECT
    CASE
        WHEN years_at_company <= 2 THEN '0-2 Years'
        WHEN years_at_company <= 5 THEN '3-5 Years'
        WHEN years_at_company <= 10 THEN '6-10 Years'
        WHEN years_at_company <= 20 THEN '11-20 Years'
        ELSE '20+ Years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY 1
ORDER BY attrition_rate_percentage DESC;

--8. How does job satisfaction relate to employee attrition?
SELECT
    jobsatisfaction,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY jobsatisfaction
ORDER BY jobsatisfaction;

--9. Is a longer period since the last promotion associated with higher attrition?
SELECT
    yearssincelastpromotion,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY yearssincelastpromotion
ORDER BY yearssincelastpromotion;

--10. How does monthly income relate to employee attrition?
SELECT
    CASE
        WHEN monthlyincome < 3000 THEN 'Below 3000'
        WHEN monthlyincome < 5000 THEN '3000-4999'
        WHEN monthlyincome < 8000 THEN '5000-7999'
        ELSE '8000+'
    END AS income_band,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY 1
ORDER BY MIN(monthlyincome);


--11. Which department and job role combinations are potential attrition hotspots?
SELECT
    department,
    jobrole,
    overtime,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY
    department,
    jobrole,
    overtime
HAVING COUNT(*) >= 10
ORDER BY
    attrition_rate_percentage DESC,
    employees_exited DESC;


--12. Which employee groups should management prioritize for retention analysis?
SELECT
    department,
    CASE
        WHEN age <= 25 THEN '18-25'
        WHEN age <= 35 THEN '26-35'
        WHEN age <= 45 THEN '36-45'
        WHEN age <= 55 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    CASE
        WHEN yearsatcompany <= 2 THEN '0-2 Years'
        WHEN yearsatcompany <= 5 THEN '3-5 Years'
        WHEN yearsatcompany <= 10 THEN '6-10 Years'
        ELSE '10+ Years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 1) AS employees_exited,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percentage
FROM employees
GROUP BY 1, 2, 3
HAVING COUNT(*) >= 10
ORDER BY
    attrition_rate_percentage DESC,
    employees_exited DESC;