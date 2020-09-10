VARIABLE v_max_depart NUMBER
VARIABLE nuevo_dept VARCHAR2(30)
DEFINE nomb_dept = 'EDUCATION'
DEFINE p_loc = 1700
DEFINE p_dept = 280

DECLARE

   max_dept_id hr.departments.department_id%TYPE;
   
BEGIN
    :nuevo_dept := '&nomb_dept';
    
    SELECT MAX(department_id)
    INTO max_dept_id
    FROM HR.employees;
    
    UPDATE hr.departments
    SET location_id = &p_loc
    WHERE department_id = &p_dept;
    
    
    :v_max_depart := max_dept_id;
END;

PRINT v_max_depart
    

