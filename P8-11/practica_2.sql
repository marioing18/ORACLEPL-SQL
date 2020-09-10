VARIABLE v_max_depart NUMBER

DECLARE

   max_dept_id hr.departments.department_id%TYPE;
   
BEGIN
    SELECT MAX(department_id)
    INTO max_dept_id
    FROM HR.employees;
    
    :v_max_depart := max_dept_id;
END;

PRINT v_max_depart
    