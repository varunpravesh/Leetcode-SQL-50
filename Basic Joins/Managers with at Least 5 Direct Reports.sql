SELECT
    name
FROM
    Employee
WHERE
    id IN (
    SELECT
        managerid
    FROM
        Employee
    GROUP BY
        managerid
    HAVING
        COUNT(*) > 4
    );