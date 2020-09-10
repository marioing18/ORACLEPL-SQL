
INSERT INTO HR.my_employee
    VALUES('&identificacion', '&&apellido', '&&nombre', 
    CONCAT(SUBSTR('&&nombre',0,1), '&&apellido'), &salario);

SELECT * FROM HR.MY_EMPLOYEE; 


