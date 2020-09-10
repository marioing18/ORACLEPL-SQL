--CODIGO DE TAREA

DEFINE p_num1 = 2
DEFINE p_num2 = 4
VARIABLE num_res NUMBER

SET VERIFY OFF

DECLARE
    num1 NUMBER(3,2) := &p_num1;
    num2 NUMBER(3,2) := &p_num2;
        
BEGIN
    :num_res := num1 / num2 + num2;
    DBMS_OUTPUT.PUT_LINE(:num_res);
END;
