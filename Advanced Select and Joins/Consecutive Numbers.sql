WITH A AS (
    SELECT
        id,
        num,
        ROW_NUMBER() OVER(PARTITION BY num ORDER BY num, id) AS Rnum,
        id - CAST(ROW_NUMBER() OVER(PARTITION BY num ORDER BY num, id) AS signed) AS Gaps
    FROM Logs
)

-- SELECT * FROM A

SELECT DISTINCT(num) AS ConsecutiveNums
FROM A
GROUP BY num, gaps
HAVING COUNT(gaps) >= 3;

-- Alternative query:
-- WITH A AS (
--     SELECT
--         id,
--         num,
--         ROW_NUMBER() OVER(PARTITION BY num ORDER BY num) AS Rnum
--     FROM Logs
-- )
-- SELECT
--     id,
--     num,
--     Rnum,
--     (id - CAST(Rnum AS signed)) AS Gaps
-- FROM A;

-- View more