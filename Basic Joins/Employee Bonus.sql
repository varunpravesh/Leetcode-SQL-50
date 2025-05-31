SELECT E.name,
       B.bonus
FROM Employee E
LEFT JOIN Bonus B ON E.empid = B.empid
WHERE B.bonus < 1000
   OR B.bonus IS NULL;
