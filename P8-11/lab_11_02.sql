SELECT C1.column_name "NOMBRE DE COLUMNA", C2.constraint_type "TIPO DE CONST",
       C2.search_condition "COND. DE BUSQ.", C2.status "ESTADO P/ TABLA"
FROM user_cons_columns C1 JOIN user_constraints C2 ON C1.constraint_name = C2.constraint_name
WHERE C2.TABLE_NAME ='&NOMBRE_DE_TABLA';