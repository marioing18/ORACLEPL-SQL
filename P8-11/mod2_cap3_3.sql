/*BLOQUE EJ5*/
DECLARE
V_SALARIO NUMBER;
V_AUMENTO NUMBER; 
V_EMPLEADO VARCHAR2(100); 
V_MENSAJE VARCHAR2(100):='se incremento el salario del empleado ';

BEGIN 

V_EMPLEADO := 'xavier alejandro monreal martinez'; 
V_SALARIO := 20000.99; 
V_AUMENTO := 1099.867; 
DBMS_OUTPUT.PUT_LINE(UPPER(V_MENSAJE)||
                        INITCAP(V_EMPLEADO)||
                        ' A '||TO_CHAR(TRUNC(V_SALARIO,2)+ ROUND(V_AUMENTO,2)));
END;