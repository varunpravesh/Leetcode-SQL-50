WITH A AS
(
    (
        SELECT 
            product_id,
            new_price AS price
        FROM Products
        WHERE (product_id, change_date) IN 
        (
            SELECT 
                product_id,
                MAX(change_date) AS date
            FROM Products
            WHERE change_date <= '2019-08-16'
            GROUP BY product_id
        )
    )
    UNION
    (
        SELECT
            product_id,
            10 AS price
        FROM Products
        WHERE change_date > '2019-08-16'
        GROUP BY product_id
    )
)
SELECT 
    product_id,
    MAX(price) AS price
FROM A
GROUP BY product_id;

/*
SELECT product_id, 
       CASE WHEN change_date <= '2019-08-16' THEN new_price ELSE 10 END AS price 
FROM Products 
GROUP BY product_id;
*/

View more