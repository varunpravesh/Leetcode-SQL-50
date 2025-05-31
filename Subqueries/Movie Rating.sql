-- SQL Query for Movie Rating

-- First part: Using CTE UserReviewCount
WITH UserReviewCount AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY movie_id) AS row_num
    FROM MovieRating
)

-- Query to get the user name with the highest row number
SELECT
    US.name AS results
FROM UserReviewCount UR
JOIN Users US ON UR.user_id = US.user_id
GROUP BY UR.user_id
ORDER BY MAX(UR.row_num) DESC, US.name
LIMIT 1

UNION ALL

-- Second part: Get the movie title
SELECT
    Mov.title AS results
FROM MovieRating MovRating
JOIN Movies Mov ON MovRating.movie_id = Mov.movie_id
WHERE LEFT(MovRating.created_at, 7) = '2020-02'
GROUP BY MovRating.movie_id
ORDER BY AVG(rating) DESC, Mov.title
LIMIT 1;