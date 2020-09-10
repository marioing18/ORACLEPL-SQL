/*INICIO BLOQUE ANONIMO*/ 
DECLARE 
/*Se crea variable V_UPD_EMP_ID para corregir los ids de los empleados*/ 
V_UPD_EMP_ID NUMBER; 

BEGIN 
/*Se asigna el id 2 al empleado Javier Flores*/ 
V_UPD_EMP_ID := 2; 

UPDATE XX_EMP_TBL_PRAC4 
SET EMP_ID = V_UPD_EMP_ID 
WHERE EMP_NAME = 'Javier Flores'; 

/*Se asigna el id 3 al empleado Jose Martinez*/ 
V_UPD_EMP_ID := 3; 

UPDATE XX_EMP_TBL_PRAC4 
SET EMP_ID = V_UPD_EMP_ID 
WHERE EMP_NAME = 'Jose Martinez'; 

/*Se asigna el id 100 al empleado Pedro Hernandez*/ 
V_UPD_EMP_ID := 100; 

UPDATE XX_EMP_TBL_PRAC4 
SET EMP_ID = V_UPD_EMP_ID 
WHERE EMP_NAME = 'Pedro Hernandez'; 

/*Se asigna el id 4 al empleado Luis Zapata*/ 
V_UPD_EMP_ID := 4; 

    UPDATE XX_EMP_TBL_PRAC4 
    SET EMP_ID = V_UPD_EMP_ID 
    WHERE EMP_NAME = 'Luis Zapata'; 

COMMIT;

END; 
/*FIN BLOQUE ANONIMO*/