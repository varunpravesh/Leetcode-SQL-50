SELECT 
    CASE 
        WHEN (
            SELECT salary 
            FROM Employee 
            ORDER BY salary DESC 
            LIMIT 1
        ) = (
            SELECT salary 
            FROM Employee 
            ORDER BY salary ASC 
            LIMIT 1
        ) THEN NULL 
        WHEN (
            SELECT COUNT(*) 
            FROM Employee
        ) > 1 THEN (
            SELECT DISTINCT salary 
            FROM Employee 
            ORDER BY salary DESC 
            LIMIT 1, 1
        ) 
        ELSE NULL 
    END AS SecondHighestSalary;