--Part A: Sub-Queries and Nested-Selects
--------------------------------------------------------------

--Query A1: Enter a failing (i.e. which gives an error) to retrieve all employees whose salary is greater than the average salary

--Query A2: Enter a working query using a sub-select to retrieve all employees whose salary is greater than the average salary
SELECT * FROM EMPLOYEES WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

--Query A3: Enter a failing query (i.e. that gives an error) that retrieves all employees records and average salary in every row

--Query A4: Enter a Column Expression that retrieves all employees records and average salary (que es siempre el mismo) in every row
SELECT *, (SELECT AVG(SALARY) AS AVG_SALARY FROM EMPLOYEES) FROM EMPLOYEES;

--Query A5: Enter a Table Expression that retrieves only the columns with non-sensitive employee data
SELECT * FROM (SELECT EMP_ID, F_NAME, L_NAME, DEP_ID FROM EMPLOYEES) AS EMP4ALL;
-- Esto me parece super redundante porque se podría haber hecho así (usando sólo el SELECT de adentro):
SELECT EMP_ID, F_NAME, L_NAME, DEP_ID FROM EMPLOYEES;

--Part B: Accessing Multiple Tables with Sub-Queries
-------------------------------------------------------------------------------

--Query B1: Retrieve only the EMPLOYEES records that correspond to departments in the DEPARTMENTS table
-- Acá el match hay que hacerlo a través del campo DEP_ID/DEPT_ID_DEP
-- Esto me parece un mal ejemplo, porque todos los DEP_ID están en las 2 tablas, así que esto simplemente devuelve la 1er tabla entera. No filtra nada.
SELECT * FROM EMPLOYEES WHERE DEP_ID IN (SELECT DEPT_ID_DEP FROM DEPARTMENTS);

--Query B2: Retrieve only the list of employees from location L0002
-- Acá hay que notar que hay 1 location para cada departamento:
SELECT * FROM EMPLOYEES WHERE DEP_ID IN (SELECT DEPT_ID_DEP FROM DEPARTMENTS WHERE LOC_ID='L0002');

--Query B3: Retrieve the department ID and name for employees who earn more than $70,000
-- Acá se refiere al nombre del departamento, no de la persona.
SELECT DEPT_ID_DEP, DEP_NAME FROM DEPARTMENTS WHERE DEPT_ID_DEP IN (SELECT DEP_ID FROM EMPLOYEES WHERE SALARY>70000);

--Query B4: Specify 2 tables in the FROM clause (Esto es un implicit JOIN.)
SELECT * FROM EMPLOYEES, DEPARTMENTS;

--Accessing Multiple Tables with Implicit Joins
---------------------------------------------------------------------

--Query B5: Retrieve only the EMPLOYEES records that correspond to departments in the DEPARTMENTS table
-- Esto ya me lo pidió en B1, pero acá quiere que lo haga de otra forma. A mí me parecía un ejemplo malísimo porque no filtra nada.
SELECT * FROM EMPLOYEES, DEPARTMENTS WHERE EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP;

--Query B6: Use shorter aliases for table names
SELECT * FROM EMPLOYEES E, DEPARTMENTS D WHERE E.DEP_ID = D.DEPT_ID_DEP;

--Query B7: Retrieve only the Employee ID and Department name in the above query
SELECT E.EMP_ID, D.DEP_NAME FROM EMPLOYEES E, DEPARTMENTS D WHERE E.DEP_ID = D.DEPT_ID_DEP;
--Parece que acá en el SELECT no hacía falta usar el prefijo, directamente se podía usar EMP_ID, DEP_NAME.

--Query B8: In the above query specify the fully qualified column names with aliases in the SELECT clause
-- Es lo que yo había hecho de entrada en B7
