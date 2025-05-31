SELECT
    A.employee_id,
    A.name,
    COUNT(B.name) AS reports_count,
    ROUND(AVG(B.age)) AS average_age
FROM Employees A
JOIN Employees B
    ON A.employee_id = B.reports_to
GROUP BY
    A.employee_id,
    A.name
ORDER BY
    employee_id;