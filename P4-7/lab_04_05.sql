SELECT job_id "TRABAJO", AVG(salary) "Promedio por trabajo", SUM(salary) "Total por trabajo",
SUM((CASE department_id WHEN 20 THEN SALARY ELSE NULL END)) "DEP 20",
SUM((CASE department_id WHEN 50 THEN SALARY ELSE NULL END)) "DEP 50",
SUM((CASE department_id WHEN 80 THEN SALARY ELSE NULL END)) "DEP 80",
SUM((CASE department_id WHEN 90 THEN SALARY ELSE NULL END)) "DEP 90"
FROM HR.employees
GROUP BY job_id;
