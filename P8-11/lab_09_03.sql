CREATE TABLE HR.EMP
    (
     ID NUMBER(7),
     Last_name VARCHAR2(25),
     First_name VARCHAR2(25),
     Dept_id NUMBER(7) REFERENCES HR.DEPT(ID)  
     );