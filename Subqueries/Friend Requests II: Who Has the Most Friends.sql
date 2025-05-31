WITH RequestsSent AS (
    SELECT requester_id AS id,
           COUNT(accepter_id) AS CountNum
    FROM RequestAccepted
    GROUP BY requester_id
    ORDER BY requester_id
),
FrendReqAccepted AS (
    SELECT accepter_id AS id,
           COUNT(requester_id) AS CountNum
    FROM RequestAccepted
    GROUP BY accepter_id
    ORDER BY accepter_id
)
SELECT id,
       SUM(CountNum) AS num
FROM (
    SELECT id, CountNum FROM RequestsSent
    UNION ALL
    SELECT id, CountNum FROM FrendReqAccepted
) derivedTabl
GROUP BY id
ORDER BY SUM(CountNum) DESC
LIMIT 1 more