SET SERVEROUTPUT ON;

DEFINE departamento = 10;

--�rea de declaraci�n
/*
Aqu� la variable sal_max va definiendo el valor del salario m�ximo para
cierto departamento.

La variable band, es un valor booleano que determina si es el primer salario 
que se obtiene de la b�squeda.

El cursor empleado_mayor obtiene todos los empleados de un �rea activa
*/
DECLARE

sal_max emp.sal%TYPE;

band BOOLEAN := FALSE;

BEGIN
    FOR empleados IN (SELECT empno, ename, job, sal
                      FROM EMP
                      WHERE deptno = &departamento) LOOP 
        
        IF band = FALSE THEN
            --SE TOMA EL PRIMERO COMO EL MAYOR
            
            sal_max :=  empleados.sal;
            band := TRUE;
            
            DBMS_OUTPUT.PUT_LINE(empleados.ename || ' tiene el m�ximo salario de ' 
            || sal_max || ' y su id es ' || empleados.empno);
            
        ELSIF band = TRUE AND sal_max < empleados.sal THEN
            --SE COMPARA EL PRIMERO CON OTRO QUE SEA MAYOR Y SE TOMA ESE COMO 
            --NUEVO SALARIO MAXIMO
            
            sal_max := empleados.sal;
            
            DBMS_OUTPUT.PUT_LINE(empleados.ename || ' tiene el nuevo m�ximo salario de ' 
            || sal_max || ' y su id es ' || empleados.empno);
            
        END IF;
        
    END LOOP;
    
END;