SELECT manager_id "Identificacion de manager", MIN(salary) "Salario minimo"
FROM HR.employees
GROUP BY manager_id
HAVING MIN(salary) > 6000
ORDER BY "Salario minimo" DESC;