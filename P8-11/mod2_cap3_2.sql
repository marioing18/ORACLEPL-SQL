/*BLOQUE EJ3*/
<<NIVEL1>> 
DECLARE 

FATHER_NAME VARCHAR2(20):='George';
DATE_BIRTH DATE:='20-Jul-1942'; 

BEGIN 
    <<NIVEL2>> 

    DECLARE 
    CHILD_NAME VARCHAR2(20):='Arthur';
    DATE_BIRTH DATE:='04-May-2000'; 

    BEGIN 

        DBMS_OUTPUT.PUT_LINE(FATHER_NAME); 
        DBMS_OUTPUT.PUT_LINE(NIVEL1.DATE_BIRTH); 
        DBMS_OUTPUT.PUT_LINE(CHILD_NAME); 
        DBMS_OUTPUT.PUT_LINE(NIVEL2.DATE_BIRTH); 

        <<NIVEL5>> 
        DECLARE 
        VAR1 DATE; 

        BEGIN 

            NULL; 
            
            <<NIVEL4>> 
            DECLARE 
            VAR2 DATE; 

            BEGIN 

                NULL; 

            END; 

        END; 

    END; 

END;