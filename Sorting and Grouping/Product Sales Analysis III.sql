WITH A AS (
    SELECT 
        product_id,
        MIN(year) AS first_year,
        quantity,
        price
    FROM sales
    GROUP BY product_id
)

SELECT 
    product_id,
    year AS first_year,
    quantity,
    price
FROM sales
WHERE (product_id, year) IN (
    SELECT 
        A.product_id,
        A.first_year 
    FROM A
)