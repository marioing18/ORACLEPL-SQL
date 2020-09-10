SELECT department_id, department_name FROM HR.DEPARTMENTS
WHERE department_id IN
(SELECT department_id FROM HR.DEPARTMENTS
MINUS
SELECT department_id FROM HR.EMPLOYEES WHERE job_id = 'ST_CLERK');