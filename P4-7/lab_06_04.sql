SELECT first_name || ' ' || last_name Nombre, department_id N_DPTO,job_id
FROM HR.employees
WHERE department_id = ANY (SELECT department_id
       FROM HR.departments
       WHERE location_id = 1700)
ORDER BY N_DPTO;