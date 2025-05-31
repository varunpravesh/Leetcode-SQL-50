WITH A AS (
    SELECT 
        customer_id,
        MIN(order_date) AS min_order_date,
        MIN(customer_pref_delivery_date) AS min_pref_delivery_date
    FROM Delivery
    GROUP BY customer_id
    HAVING MIN(order_date) = MIN(customer_pref_delivery_date)
)

SELECT 
    ROUND(
        (COUNT(A.customer_id) / (SELECT COUNT(DISTINCT customer_id) FROM Delivery)) * 100,
        2
    ) AS immediate_percentage
FROM A;
