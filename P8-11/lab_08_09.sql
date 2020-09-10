UPDATE HR.my_employee
SET last_name = 'Flores',
    userid = CONCAT(SUBSTR(first_name,0,1), last_name)
WHERE id = 3;

commit;