WITH FirstDay AS (
    SELECT 
        player_id,
        MIN(event_date) AS event_date
    FROM Activity
    GROUP BY player_id
    ORDER BY player_id
)
SELECT 
    ROUND(
        COUNT(DISTINCT FD.player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM FirstDay FD
JOIN Activity B ON FD.player_id = B.player_id
WHERE DATEDIFF(B.event_date, FD.event_date) = 1  -- note: 'more' text removed as it seemed extraneous