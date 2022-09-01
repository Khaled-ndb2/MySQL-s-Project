/* 1. query to fetch the EmpFname from the employee_info
table in upper case and use the ALIAS name as EmpName. */

SELECT UPPER(EmpFname) AS EmpName FROM employee_info;


--   2. query to fetch the number of employees working in the department ‘HR 

SELECT COUNT(*) FROM employee_info WHERE Department = 'HR';

--   3. query to get the current date. */


SELECT CURDATE();


--   4. query to retrieve the first four characters of EmpLname from the employee_info table. 


SELECT SUBSTRING(EmpLname, 1, 4) FROM employee_info;


/*  5. query to fetch only the place name(string before brackets) from the Address column of
employee_info table. */

SELECT SUBSTRING(Address, 1, Locate('(',Address) -1 ) FROM employee_info;


/*  6. query to create a new table that consists of data and structure copied from the other
table. */
-- remove the insert if run for 2nd time

CREATE TABLE if not exists  NewTable AS SELECT  * FROM  employee_info;


-- INSERT INTO NewTable SELECT * FROM employee_info;


--  7.  query to find all the employees whose salary is between 50000 to 100000. 


SELECT EmpID, sum(Salary) FROM employee_position Group by EmpID  HAVING SUM(Salary) BETWEEN 50000 AND 100000;

--  8. query to find the names of employees that begin with ‘S’ 


SELECT * FROM employee_info WHERE EmpFname LIKE 'S%';

--     9. Write a query to fetch top N records derivedD is the name of the drived table. 


SET @limit := 3;
SET @rownum := 0;
SELECT EmpID, EmpPosition, DateOfJoining, Salary FROM
(    
    SELECT employee_position.*, @rownum := @rownum + 1 AS rowNum
    FROM employee_position order by Salary DESC
) derivedD WHERE rowNum <= @limit;

/*    10. query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be 
separated with space. */

SELECT CONCAT(EmpFname, ' ', EmpLname) AS 'FullName' FROM employee_info;



/*     11. query find number of employees whose DOB is between 02/05/1970 to 31/12/1975
and are grouped according to gender. */


SELECT COUNT(*), Gender FROM employee_info WHERE DOB BETWEEN '1970/05/02' AND '1975/12/31' GROUP BY Gender;


/*     12. query to fetch all the records from the employee_info table ordered by EmpLname in
descending order and Department in the ascending order.*/

SELECT * FROM employee_info ORDER BY EmpFname desc, Department asc;


/*     13. query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and
contains five alphabets. */

SELECT * FROM employee_info WHERE EmpLname LIKE '____a';


/*     14. query to fetch details of all employees excluding the employees with first names,
“Sanjay” and “Sonia” from the employee_info table. */


SELECT * FROM employee_info WHERE EmpFname NOT IN ('Sanjay','Sonia');


--      15.  query to fetch details of employees with the address as “DELHI(DEL)”. 

SELECT * FROM employee_info WHERE Address = 'DELHI(DEL)';


--     16. query to fetch all employees who also hold the managerial position. 


SELECT E.EmpFname, E.EmpLname, P.EmpPosition FROM employee_info E INNER JOIN employee_position

 P ON E.EmpID = P.EmpID AND P.EmpPosition IN ('Manager');

/*     17. query to fetch the department-wise count of employees sorted by department’s count in
ascending order.*/



SELECT Department, count(EmpID) AS EmpDeptCount FROM employee_info

 GROUP BY Department ORDER BY EmpDeptCount ASC;



--      18. query to calculate the even and odd records from a table. 



SET @rowno :=0;
SELECT EmpID FROM (SELECT @rowno:=@rowno+1 as r , EmpID from employee_info) d WHERE (r % 2)=0;
SET @rowno :=0;
SELECT EmpID FROM (SELECT @rowno:=@rowno+1 as r1 , EmpID from employee_info) d WHERE (r1 % 2)=1;


/*     19. a SQL query to retrieve employee details from employee_info table who have a date of
joining in the employee_position table.*/


SELECT * FROM employee_info E WHERE EXISTS (SELECT * FROM employee_position P WHERE E.EmpId = P.EmpId);


--     20. a query to retrieve two minimum and maximum salaries from the employee_position table. 



SELECT Max(salary) as 'max salary' , min(salary) as ' min salary' from employee_position;


	
--       21. a query to find the Nth highest salary from the table without using TOP/limit keyword. 


SET @N :=0;
SELECT Salary FROM employee_position E1 WHERE N-1 = ( SELECT COUNT( DISTINCT ( E2.Salary ) ) FROM employee_position E2 WHERE E2.Salary > E1.Salary );



--        22.  query to retrieve duplicate records from a table.



SELECT EmpID, EmpFname, Department, COUNT(*) FROM employee_info GROUP BY EmpID, EmpFname, Department HAVING COUNT(*) > 1;

--         23. query to retrieve the list of employees working in the same department. 



SELECT DISTINCT
    E.EmpID, E.EmpFname, E.Department
FROM
    employee_info E
        JOIN
    employee_info E1 ON (E.Department = E1.Department)
WHERE
    E.EmpID <> E1.empID
ORDER BY Department;



--        24. query to retrieve the last 3 records from the employee_info table.  


SELECT * FROM employee_info WHERE EmpID <=3 UNION SELECT * FROM (SELECT * FROM employee_info E ORDER BY E.EmpID DESC) AS E1 WHERE E1.EmpID <=3;



--        25. query to find the third-highest salary from the EmpPosition table. 

-- SELECT limit 1 salary FROM( ORDER BY salary DESC) AS emp ORDER BY salary ASC;


SELECT Salary FROM employee_position ORDER BY Salary DESC LIMIT 2 , 1;

--        26. query to display the first and the last record from the employee_info table. 



SELECT * FROM employee_info WHERE EmpID = (SELECT MIN(EmpID) FROM employee_info);
SELECT * FROM employee_info WHERE EmpID = (SELECT MAX(EmpID) FROM employee_info);


--        27. query to add email validation to your database */


 SELECT * FROM employee_info WHERE Email REGEXP "^[a-zA-Z0-9.!#$%&'+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)$";


--         28. query to retrieve Departments who have less than 2 employees working in it. 


SELECT DEPARTMENT, COUNT(EmpID) as 'EmpNo' FROM employee_info GROUP BY DEPARTMENT HAVING COUNT(EmpID) < 2;


--         29.  query to retrieve EmpPostion along with total salaries paid for each of them. 


SELECT EmpPosition, SUM(Salary) from employee_position GROUP BY EmpPosition;


--         30. query to fetch 50% records from the employee_info table.

SELECT * FROM employee_info WHERE EmpID <= (SELECT COUNT(EmpID)/2 from employee_info);