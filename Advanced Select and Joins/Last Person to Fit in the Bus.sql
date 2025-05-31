WITH Cumulative_Weight AS (
    SELECT 
        turn,
        person_name,
        weight,
        SUM(weight) OVER (ORDER BY Turn) AS Total_weight
    FROM Queue
    ORDER BY Turn
)

SELECT 
    person_name
FROM Cumulative_Weight
WHERE Total_weight <= 1000
GROUP BY person_name
ORDER BY MAX(Total_weight) DESC
LIMIT 1;