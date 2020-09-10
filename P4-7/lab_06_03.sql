SELECT employee_id, first_name || ' ' || last_name NOMBRE
FROM HR.employees
WHERE UPPER(first_name) LIKE '%U%' OR UPPER(last_name) LIKE '%U%'
ORDER BY employee_id;
