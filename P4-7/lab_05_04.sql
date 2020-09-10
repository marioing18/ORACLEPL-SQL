SELECT E1.employee_id, E1.first_name || ' ' || E1.last_name Empleado,
E2.first_name || ' ' || E2.last_name Manager 
FROM HR.employees E1 LEFT JOIN 
HR.employees E2
ON (E1.manager_id = E2.employee_id)
ORDER BY employee_id;
