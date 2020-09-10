SELECT first_name Nombre, last_name Apellido, salary, salary * 1.15 "NEW SALARY", salary * 1.15 - salary as Increase
FROM HR.employees;