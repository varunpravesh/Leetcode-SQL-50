SELECT 
    A.id 
FROM 
    Weather A 
CROSS JOIN 
    Weather B 
WHERE 
    DATEDIFF(DAY, B.recordDate, A.recordDate) = 1
    AND A.temperature > B.temperature;