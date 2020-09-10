SELECT hr.em.last_name, hr.em.job_id, hr.em.department_id, hr.d.department_name
FROM HR.locations l JOIN 
        HR.departments d ON HR.l.location_id = HR.d.location_id
        JOIN 
        HR.employees em ON HR.d.department_id = HR.em.department_id
        WHERE city = 'Toronto';
