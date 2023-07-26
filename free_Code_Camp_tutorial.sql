CREATE TABLE student (
	student_id INT PRIMARY KEY,
    #INT being integer and setting student_id as the primary key
    name VARCHAR (20),
    degree VARCHAR (20)
    #Varchar meaning the maximum of each string
);
#always close statements with a semicolon

DESCRIBE student; 
# decribes rows and columns in table

ALTER TABLE student ADD gpa DECIMAL(3, 2); 
# Adds coloumn to table, decimal being 3 digits with 2 coming after decimal point

ALTER TABLE student DROP COLUMN gpa; 
#drop column from table

SELECT * FROM student;

INSERT INTO student VALUES (1, 'Jack', 'Biology', 4.0);
INSERT INTO student VALUES (2, 'Kate', 'Economics', 3.9);
INSERT INTO student VALUES (5, 'Mike', 'English', 3.8);
#Must add values into the table in the same order as set out in the created table

INSERT INTO student(student_id, name) VALUES (3, 'Claire');
INSERT INTO student(student_id, name) VALUES (4, 'Claire');
#When there are unknown values, you can specify which columns to add data to

SET SQL_SAFE_UPDATES = 0;

UPDATE student  
SET degree = 'Bio'
WHERE degree = 'Biology';

UPDATE student 
SET name = 'Sally'
WHERE student_id = 4;
#Update can modify existing records in a database, either multiple records ('Biology') or specific records ('Sally')

DELETE FROM student 
WHERE student_id = 4;
#Deleting records using WHERE to specify which rows to delete 



