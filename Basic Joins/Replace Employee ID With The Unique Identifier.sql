SELECT 
    EmpUni.unique_id,
    Emp.name
FROM 
    Employees Emp
LEFT JOIN 
    EmployeeUni EmpUni ON Emp.id = EmpUni.id;