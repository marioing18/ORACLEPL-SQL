CREATE VIEW EMPLOYEES_VU AS
    SELECT employee_id, first_name || ' ' || last_name EMPLOYEE, department_id
    FROM HR.employees;