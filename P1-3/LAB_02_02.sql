SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME "NOMBRE COMPLETO" 
FROM HR.EMPLOYEES
WHERE COMMISSION_PCT IS NULL;