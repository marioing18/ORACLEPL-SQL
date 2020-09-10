SELECT first_name || ' ' || last_name Nombre, hire_date
FROM HR.employees
WHERE hire_date > (SELECT hire_date 
FROM HR.EMPLOYEES
WHERE last_name = 'Davies')
ORDER BY hire_date ASC;
