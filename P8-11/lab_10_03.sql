CREATE VIEW DEPT50 AS
    SELECT employee_id EMPNO, first_name || ' ' || last_name EMPLOYEE, department_id DEPNO
    FROM HR.employees
    WHERE department_id = 50;
    
