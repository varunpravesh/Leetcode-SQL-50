WITH SalaryRank AS (
    SELECT 
        D.name AS Department,
        E.name AS Employee,
        E.salary AS Salary,
        DENSE_RANK() OVER (PARTITION BY E.departmentId ORDER BY Salary DESC) AS SalRank
    FROM Employee E
    JOIN Department D ON E.departmentId = D.id
)

SELECT 
    Department,
    Employee,
    Salary
FROM SalaryRank
WHERE SalRank <= 3;