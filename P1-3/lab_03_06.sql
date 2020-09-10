SELECT JOB_ID "JOB", DECODE(JOB_ID,
'AD_PRES','A',
'ST_MAN','B',
'IT_PROG', 'C',
'SA_REP','D',
'ST_CLERK','E',
'0') GRADE
FROM HR.employees; 