SELECT job_id, department_id FROM HR.EMPLOYEES
INTERSECT
SELECT job_id, department_id FROM HR.EMPLOYEES WHERE department_id = 10
                                                  OR department_id = 20
                                                  OR department_id = 50;
