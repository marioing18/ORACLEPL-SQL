SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME "NOMBRE COMPLETO"
FROM HR.EMPLOYEES
WHERE HIRE_DATE BETWEEN '01-APR-1980' AND '02-APR-1985';