SELECT COUNT(employee_id) "Empleados totales", 
COUNT((CASE EXTRACT(YEAR FROM hire_date) WHEN 1995 THEN 1 ELSE NULL END)) "CONT 1995",
COUNT((CASE EXTRACT(YEAR FROM hire_date) WHEN 1996 THEN 1 ELSE NULL END)) "CONT 1996",
COUNT((CASE EXTRACT(YEAR FROM hire_date) WHEN 1997 THEN 1 ELSE NULL END)) "CONT 1997",
COUNT((CASE EXTRACT(YEAR FROM hire_date) WHEN 1998 THEN 1 ELSE NULL END)) "CONT 1998"
FROM HR.employees;
