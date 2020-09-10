SELECT employee_id Identificacion, first_name Nombre, salary Salario, department_id Departamento
FROM HR.employees
WHERE manager_id = &nro_manager
ORDER BY Nombre, Salario, Departamento DESC;