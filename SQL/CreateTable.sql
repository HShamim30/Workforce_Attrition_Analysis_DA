CREATE TABLE Employees(
Age INT,
Attrition INT,
BusinessTravel VARCHAR(50),
DailyRate INT,
Department VARCHAR(50),
DistanceFromHome INT,
Education INT,
EducationField VARCHAR(50),
EnvironmentSatisfaction INT,
Gender VARCHAR(50),
HourlyRate INT,
JobInvolvement INT,
JobLevel INT,
JobRole VARCHAR(50),
JobSatisfaction INT,
MaritalStatus VARCHAR(50),
MonthlyIncome INT,
MonthlyRate INT,
NumCompaniesWorked INT,
OverTime VARCHAR(10),
PercentSalaryHike INT,
PerformanceRating INT,
RelationshipSatisfaction INT,
StockOptionLevel INT,
TotalWorkingYears INT,
TrainingTimesLastYear INT,
WorkLifeBalance INT,
YearsAtCompany INT,
YearsInCurrentRole INT,
YearsSinceLastPromotion INT,
YearsWithCurrManager INT
);
SELECT * FROM Employees;
TRUNCATE TABLE public.employees;

COPY public.employees
FROM 'F:/Workforce_Attrition_Analysis/data/Palo_Alto_Networks.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"'
);