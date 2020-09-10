SELECT employee_id, first_name || ' ' || last_name NOMBRE, salary
FROM HR.employees
WHERE salary > ANY
        (SELECT AVG(salary)
        FROM HR.employees) AND
        (UPPER(first_name) LIKE '%U%' OR UPPER(last_name) LIKE '%U%');