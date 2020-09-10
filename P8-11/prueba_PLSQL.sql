DECLARE
    v_variable VARCHAR(25);
BEGIN
    SELECT first_name
    INTO v_variable
    FROM HR.employees
    WHERE employee_id = 100;
END;