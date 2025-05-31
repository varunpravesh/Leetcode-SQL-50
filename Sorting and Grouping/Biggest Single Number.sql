WITH A AS (
    SELECT 
        num 
    FROM 
        MyNumbers
    GROUP BY 
        num
    HAVING 
        COUNT(num) = 1
)

SELECT 
    MAX(A.num) AS num 
FROM 
    A;