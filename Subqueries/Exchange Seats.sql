SELECT id,
       CASE
           WHEN id = (SELECT MAX(id) FROM Seat) AND id % 2 != 0 THEN student
           WHEN id % 2 = 0 THEN LAG(student) OVER (ORDER BY id)
           ELSE LEAD(student) OVER (ORDER BY id)
       END AS student
FROM Seat;

/*
# Write your MySQL query statement below

SELECT id,
       CASE
           WHEN id % 2 = 0 THEN LAG(student) OVER (ORDER BY id)
           ELSE COALESCE(LEAD(student) OVER (ORDER BY id), student)
       END AS student
FROM Seat;
*/

View more