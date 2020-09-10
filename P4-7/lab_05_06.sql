SELECT HR.E1.first_name || ' ' || HR.E1.last_name Nombre, HR.E1.hire_date Contratacion,
HR.E2.first_name || ' ' || HR.E2.last_name Manager, HR.E2.hire_date "Fecha de manager"
FROM HR.employees E1, HR.employees E2
WHERE E1.manager_id = E2.employee_id AND
E1.hire_date < E2.hire_date;
