CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

#Basic Functions

#find all employees
select * from employee;

#find all clients
select * from client;

#find all employees ordered by salary
select * from employee
order by salary desc;

#find all employees ordered by sex then name
select * from employee
order by sex, first_name, last_name;

#find the first 5 employees in the table 
select * from employee
limit 5;

#find the first and last names of all employees
select first_name, last_name from employee;

#find the forename and surname of all employees
select first_name AS forename, last_name AS surname from employee;

#find out all the different genders
select distinct sex from employee;

#Functions 

#find the number of employees 
Select count(emp_id) from employee;

#find the number of female employees born after 1970
select count(emp_id) from employee
where sex = 'F' and birth_day > '1970-01-01';

#find the average of all employee's salaries who are male
select avg(salary) from employee
where sex = 'M';

#find the sum of all employees salaries
select sum(salary) from employee;

#aggregation
#find out how many males and females there are
select count(sex), sex
from employee
group by sex;

#find the total sales of each salesman
select sum(total_sales), emp_id
from works_with
group by emp_id;

#Wildcards
#find any clients who are an LLC
SELECT * from client
where client_name LIKE '%LLC%';

#find any branch suppliers who are in the label business
select * from branch_supplier
where supplier_name like '%Label%';

#find any employee born in October 
select * from employee
where birth_day like '____-10%';
#here I used 4 _'s and a % at the end

#Unions 

#find a list of employee and branch names 
select first_name from employee
union 
select branch_name from branch
union
select client_name from client;

#find a list of all money spent or earned by the company
select sum(salary) from employee
union 
select sum(total_sales) from works_with;

#joins
insert into branch values(4, 'Buffalo', null,null);

#find all the branches and the names of their managers
#in the branch table there are mgr_id's which are emp_id's in the employee table. 
select employee.emp_id, employee.first_name, branch.branch_name
from employee
join branch #this joins the employee table and branch table together 
on employee.emp_id = branch.mgr_id; # only emp_id's from the employees table is in the branch table as mgr_id
 # this is also called an inner join 
 
 #nested queries
 
 #find names of all employees who have sold over 30,000 to a single client
 select employee.first_name, employee.last_name
 from employee
where employee.emp_id IN (
	select works_with.emp_id 
	from works_with
	where works_with.total_sales > 30000
);
#using the IN function will output all the first and last names of employees
#where they have sold more than 30k

#find all clients who are handles by the branch that Micheal Scott manages
#assume you know Michael's ID
select client.client_name 
from client 
where client.branch_id = (
	select branch.branch_id 
	from branch
	where branch.mgr_id = 102);
#this should give us the branch name that michael (102) manages 

#ON DELETE - When data is deleted which is associated with a foreign key
#ON DELETE SET NULL - when a row is deleted, the foreign key gets set to null
#ON DELETE CASCADE - When a foreign key is deleted, the whole row gets deleted




 
 

 
 
 


 










