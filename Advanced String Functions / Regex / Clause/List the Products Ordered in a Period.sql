WITH CTE AS (
    SELECT product_id,
           SUM(unit) AS unit
    FROM Orders
    WHERE order_date LIKE '2020-02%'
    GROUP BY product_id
    HAVING SUM(unit) >= 100
)

SELECT Prod.product_name,
       CTE.unit
FROM Products Prod
JOIN CTE ON Prod.product_id = CTE.product_id;
