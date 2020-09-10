SELECT employee_id, job_id FROM hr.job_history
WHERE employee_id IN(SELECT employee_id 
    FROM HR.job_history
    GROUP BY employee_id
    HAVING COUNT(employee_id) < 2)
MINUS
SELECT employee_id, job_id FROM hr.employees;