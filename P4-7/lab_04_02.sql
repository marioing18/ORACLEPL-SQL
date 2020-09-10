SELECT job_id "Empleo", COUNT(job_id) "Cantidad de Personas"
FROM HR.employees
GROUP BY job_id;