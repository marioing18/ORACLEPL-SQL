
/*
    SCRIPT PARA ALMACENAR EL PAQUETE QUE CONTIENE LAS FUNCIONES Y PROCEDIMIENTOS
    QUE CALCULAN EL TIEMPO DE ENTREGA DE LOS REGISTROS
    EJECUTAR DE TERCERO
*/
SET SERVEROUTPUT ON

CREATE OR REPLACE PACKAGE CALCULO_PEDIDOS IS
    
    --FUNCION PARA VERIFICAR SI EL INTERVALO DE DESCANSO COINCIDE CON EL DE ENTREGA
    FUNCTION COINCIDENCIA (FECHA_P_I IN DATE, T_EST IN NUMBER, 
                           FECHA_D_I IN DATE, FECHA_D_F IN DATE)
    RETURN BOOLEAN;
    --FUNCION PARA CALCULAR LA DIFERENCIA EN HORAS ENTRE DOS FECHAS DADAS
    FUNCTION CALCULO_HORA (FECHA1 IN DATE,
                           FECHA2 IN DATE)
    RETURN NUMBER;
       
    PROCEDURE UPD_FECHA; 

END CALCULO_PEDIDOS;
/

CREATE OR REPLACE PACKAGE BODY CALCULO_PEDIDOS IS

    --DESARROLLO DE FUNCION DE COINCIDENCIA
    /*
    FUNCION QUE VERIFICA LOS POSIBLES INTERVALOS DE COINCIDENCIA EXISTENTES UNA FECHA RECIBIDA,
    EL TIEMPO ESTIMADO DE LA PROXIMA FECHA, ADEMÁS DE DOS VARIABLES DE TIPO FECHA QUE DETERMINAN
    EL INTERVALO DE INTERSECCION CON LA FECHA QUE SE RECIBE
    */
    FUNCTION COINCIDENCIA (FECHA_P_I IN DATE, T_EST IN NUMBER, FECHA_D_I IN DATE, FECHA_D_F IN DATE)
    RETURN BOOLEAN
    IS
    
    V_PRUEBA BOOLEAN := FALSE;  
     
    BEGIN
    
        IF CALCULO_HORA(FECHA_P_I, FECHA_D_I) <= 0 AND CALCULO_HORA(FECHA_P_I,FECHA_D_F) < 0 THEN
        
            V_PRUEBA := FALSE; --NO HAY COINCIDENCIA DE HORARIO
            
        ELSIF CALCULO_HORA(FECHA_P_I, FECHA_D_I) <= 0 AND CALCULO_HORA(FECHA_P_I,FECHA_D_F) > 0 THEN
        
            V_PRUEBA := TRUE; --HAY COINCIDENCIA DE HORARIO
            
        ELSIF CALCULO_HORA(FECHA_P_I, FECHA_D_I) >= 0 AND CALCULO_HORA(FECHA_P_I,FECHA_D_I) > T_EST THEN
        
            V_PRUEBA := FALSE; --NO HAY COINCIDENCIA DE HORARIO
            
        ELSIF CALCULO_HORA(FECHA_P_I, FECHA_D_I) >= 0 AND CALCULO_HORA(FECHA_P_I,FECHA_D_I) < T_EST THEN
        
            V_PRUEBA := TRUE; --HAY COINCIDENCIA DE HORARIO
            
        END IF;
        
        RETURN V_PRUEBA;
    
    END COINCIDENCIA;
    
    --Calculo de horas
    /*
    FUNCION QUE DEVUELVE EL VALOR EN HORAS RESULTANTE DE LA RESTA ENTRE DOS FECHAS
    */
    FUNCTION CALCULO_HORA(FECHA1 IN DATE, FECHA2 IN DATE)
    RETURN NUMBER
    IS
    
    FECHA_PRUEBA NUMBER;
    
    BEGIN
    
        FECHA_PRUEBA := (FECHA2-FECHA1) * 24;
        RETURN FECHA_PRUEBA;    
        
    END CALCULO_HORA;
    
    
    --PROCEDIMIENTO PARA HACER EL CALCULO DE LA FECHA APROXIMADA
    
    /*
    PROCEDIMIENTO QUE REALIZA LA ACTUALIZACION DE LA TABLA PEDIDOS
    DETERMINA LA FECHA DE ENTREGA DEL ENVIO, CONSIDERANDO LA INCIDENCIA DE 
    LOS DESCANSOS PROGRAMADOS POR LA EMPRESA Y LA CANTIDAD DE SOLICITUDES EN
    COLA.
    */
    PROCEDURE UPD_FECHA
        IS
         
    --VARIABLES PARA MANEJO DE EXCEPCIONES
    MENSAJE_ERR VARCHAR2(255) := ' ';
    CODIGO_ERR NUMBER := 0;
    
    --VARIABLE QUE GUARDA UN VALOR PARCIAL DE FECHA
    N_FECHA_I DATE := TO_DATE('01-01-2020', 'DD-MM-YYYY HH24:MI:SS');
    HORAS NUMBER (6) := 0;
    ENTREGADO_PARCIAL  NUMBER(3) := 0; 
        
    --CURSORES
    CURSOR CON_PEDIDO IS
        SELECT num_ped, recibido, tiempo_est, estatus, entregado
        FROM pedidos;
        
    CURSOR CON_DESCANSO IS
        SELECT descripcion, fecha_inic, fecha_final
        FROM descansos;
        
    --CONSULTAS CON TABLAS PL/SQL
    LIMITE_CONS PLS_INTEGER := 25;
    TYPE v_pedidos_type IS TABLE OF pedidos%ROWTYPE;
    TYPE v_descansos_type IS TABLE OF descansos%ROWTYPE;
    
    
    V_PEDIDOS_TAB v_pedidos_type;
    V_DESCANSOS_TAB v_descansos_type;
         
    BEGIN
        
        OPEN CON_PEDIDO;
        FETCH CON_PEDIDO
        BULK COLLECT INTO V_PEDIDOS_TAB
        LIMIT LIMITE_CONS;
    
        OPEN CON_DESCANSO;
        FETCH CON_DESCANSO
        BULK COLLECT INTO V_DESCANSOS_TAB
        LIMIT LIMITE_CONS;
    
        FOR i in V_PEDIDOS_TAB.FIRST..V_PEDIDOS_TAB.LAST LOOP
            
           --En este ciclo se evalua un pedido para varios tipos de descanso que tome el empleado
           --Se compara cada pedido con todos los tiempos de descanso (muy ineficiente)
           
           ENTREGADO_PARCIAL := 0;
       
           --EN ESTE CICLO SE VERIFICA SI EXISTE COINCIDENCIAS CON LOS HORARIOS DE DESCANSO
            FOR j in V_DESCANSOS_TAB.FIRST..V_DESCANSOS_TAB.LAST LOOP
                
                --EL PRIMERO QUE SE PROCESA (CASO ESPECIAL)
                IF i = 1 THEN
                       
                    IF COINCIDENCIA(V_PEDIDOS_TAB(i).RECIBIDO, V_PEDIDOS_TAB(i).TIEMPO_EST, 
                        V_DESCANSOS_TAB(j).FECHA_INIC, V_DESCANSOS_TAB(j).FECHA_FINAL) = TRUE THEN
                    
                    --VARIABLE QUE ALMACENA EL VALOR DE FECHA DE ENTREGA APROXIMADA(CON INTERRUPCION) 
                        
                        HORAS := CALCULO_HORA(V_DESCANSOS_TAB(j).FECHA_INIC, V_DESCANSOS_TAB(j).FECHA_FINAL);
                        
                        ENTREGADO_PARCIAL := ENTREGADO_PARCIAL + HORAS;
                        
                        DBMS_OUTPUT.PUT_LINE('PROBANDO ANDO IN');
                        
                    END IF;
                    
                --SI NO ES EL PRIMERO DE LA LISTA DE PEDIDOS
                ELSIF  i > 1  THEN                    
                         
                    IF COINCIDENCIA(N_FECHA_I, V_PEDIDOS_TAB(i).TIEMPO_EST, 
                        V_DESCANSOS_TAB(j).FECHA_INIC, V_DESCANSOS_TAB(j).FECHA_FINAL) = TRUE THEN
                    
                    --VARIABLE QUE ALMACENA EL VALOR DE FECHA DE ENTREGA APROXIMADA(CON INTERRUPCION) 
                        HORAS := CALCULO_HORA(V_DESCANSOS_TAB(j).FECHA_INIC, V_DESCANSOS_TAB(j).FECHA_FINAL);
                        
                        N_FECHA_I := N_FECHA_I + (HORAS) / 24 ;
                         --NUEVO VALOR DE INICIO DE PROCESAMIENTO PARA EL PROXIMO PEDIDO
                         
                    END IF;
                    
                        V_PEDIDOS_TAB(i).ENTREGADO := N_FECHA_I;
                END IF;
                
                 
            END LOOP;
            
              IF i = 1 THEN
           
                    V_PEDIDOS_TAB(i).ENTREGADO := V_PEDIDOS_TAB(i).RECIBIDO + (V_PEDIDOS_TAB(i).TIEMPO_EST + ENTREGADO_PARCIAL) / 24;        
              ELSE
                    V_PEDIDOS_TAB(i).ENTREGADO := N_FECHA_I + (V_PEDIDOS_TAB(i).TIEMPO_EST) / 24 ;
               
              END IF;
                
                N_FECHA_I := V_PEDIDOS_TAB(I).ENTREGADO; --NUEVA FECHA PARA INICIAR EL PROCESADO (APLICA PARA EL SIGUIENTE PEDIDO)
                
            --ACTUALIZACIÓN DE TABLA DE PEDIDOS
            
            UPDATE PEDIDOS
            SET ENTREGADO = V_PEDIDOS_TAB(i).ENTREGADO
            WHERE num_ped = V_PEDIDOS_TAB(i).NUM_PED;
            COMMIT;
            
             
        END LOOP;
        
        CLOSE CON_PEDIDO;
        CLOSE CON_DESCANSO;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;   
            MENSAJE_ERR := SQLERRM;
            CODIGO_ERR := SQLCODE;
            DBMS_OUTPUT.PUT_LINE(CODIGO_ERR);
            DBMS_OUTPUT.PUT_LINE(MENSAJE_ERR);
        
    END UPD_FECHA;

END CALCULO_PEDIDOS;
/