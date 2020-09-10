SET SERVEROUTPUT ON;

DEFINE departamento = 10;

--área de declaración
/*
Aquí la variable sal_max va definiendo el valor del salario máximo para
cierto departamento.

La variable band, es un valor booleano que determina si es el primer salario 
que se obtiene de la búsqueda.

El cursor empleado_mayor obtiene todos los empleados de un área activa
*/
DECLARE

sal_max emp.sal%TYPE;
v_empno emp.empno%TYPE;
v_ename emp.ename%TYPE;
v_job emp.job%TYPE;
v_sal emp.sal%TYPE;
band BOOLEAN := FALSE;

CURSOR empleado_mayor IS
    SELECT empno, ename, job, sal
    FROM EMP
    WHERE deptno = &departamento;

BEGIN
    
    OPEN empleado_mayor;
    
    LOOP 
        
        FETCH empleado_mayor INTO
            v_empno, v_ename, v_job, v_sal;   
        
        IF band = FALSE THEN
            --SE TOMA EL PRIMERO COMO EL MAYOR
            
            sal_max :=  v_sal;
            band := TRUE;
            
            DBMS_OUTPUT.PUT_LINE(v_ename || ' tiene el máximo salario de ' 
            || sal_max || ' y su id es ' || v_empno);
            
        ELSIF band = TRUE AND sal_max < v_sal THEN
            --SE COMPARA EL PRIMERO CON OTRO QUE SEA MAYOR Y SE TOMA ESE COMO 
            --NUEVO SALARIO MAXIMO
            
            sal_max := v_sal;
            
            DBMS_OUTPUT.PUT_LINE(v_ename || ' tiene el nuevo máximo salario de ' 
            || sal_max || ' y su id es ' || v_empno);
            
        END IF;
        
        EXIT WHEN empleado_mayor%NOTFOUND = TRUE;
        
    END LOOP;
    
    CLOSE empleado_mayor;
    
END;