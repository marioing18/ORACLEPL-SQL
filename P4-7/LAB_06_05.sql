SELECT first_name || ' ' || last_name NOMBRE, salary SALARIO
FROM HR.employees
WHERE manager_id = ANY 
                (SELECT manager_id
                 FROM HR.employees
                 WHERE UPPER(last_name) = 'KING');
                   