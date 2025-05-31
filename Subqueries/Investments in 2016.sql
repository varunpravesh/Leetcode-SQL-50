WITH CTE AS
(
    SELECT DISTINCT(A.pid),
           A.tiv_2015,
           A.tiv_2016
    FROM Insurance A
    JOIN Insurance B
      ON A.tiv_2015 = B.tiv_2015
    WHERE A.pid != B.pid
      AND (A.lat, A.lon) NOT IN
      (
          SELECT lat, lon
          FROM Insurance
          GROUP BY lat, lon
          HAVING COUNT(lat) > 1
      )
)

SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM CTE more