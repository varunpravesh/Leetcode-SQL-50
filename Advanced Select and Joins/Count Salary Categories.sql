-- Write your PostgreSQL query statement below

SELECT 
    'High Salary' AS category, 
    COUNT(CASE WHEN income > 50000 THEN income ELSE NULL END) AS accounts_count 
FROM Accounts

UNION

SELECT 
    'Low Salary' AS category, 
    COUNT(CASE WHEN income < 20000 THEN income ELSE NULL END) AS accounts_count 
FROM Accounts

UNION

SELECT 
    'Average Salary' AS category, 
    COUNT(CASE WHEN income >= 20000 AND income <= 50000 THEN income ELSE NULL END) AS accounts_count 
FROM Accounts

ORDER BY accounts_count DESC;