WITH CTE AS (
    SELECT *,
           SUM(Customer.amount) OVER (
               ORDER BY visited_on
               RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW
           ) AS totamount,
           ROUND(
               SUM(Customer.amount) OVER (
                   ORDER BY visited_on
                   RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW
               ) / 7, 2
           ) AS average_amount
    FROM Customer
)
SELECT visited_on,
       AVG(totamount) AS amount,
       AVG(average_amount) AS average_amount
FROM CTE
WHERE DATEDIFF(visited_on, (
          SELECT visited_on
          FROM Customer
          ORDER BY visited_on
          LIMIT 1
      )) >= 6
GROUP BY visited_on;