CREATE TABLE employee (    
    first_name VARCHAR(20),
    emp_id INT,    
    last_name VARCHAR(20),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    supplier_id INT,
    branch_id INT,
    PRIMARY KEY(emp_id)
);
 
ALTER TABLE employee MODIFY COLUMN first_name VARCHAR(20) AFTER emp_id;


ALTER TABLE employee 
RENAME COLUMN supplier_id TO super_id;

CREATE TABLE branch(
   branch_id INT PRIMARY KEY,
   bramch_name VARCHAR(20),
   mgr_start_date DATE,
   mgr_id INT,
   FOREIGN KEY (mgr_id) 
   REFERENCES employee(emp_id) 
   ON DELETE SET NULL
);

ALTER TABLE branch MODIFY COLUMN mgr_start_date DATE AFTER mgr_id;

--corrected grammar for branch name
ALTER TABLE branch 
RENAME COLUMN bramch_name TO branch_name;
DESCRIBE employee;

ALTER TABLE employee
ADD FOREIGN KEY (branch_id) 
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY (super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(150),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

ALTER TABLE client DROP FOREIGN KEY client_ibfk_1;

SHOW CREATE TABLE client;
DESCRIBE branch_supplier;
DROP TABLE client; 

CREATE TABLE works_with(
    emp_id INT, 
    client_id INT,
    total_sales INT,
    PRIMARY KEY (emp_id, client_id),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier(
    branch_id INT, 
    supplier_name VARCHAR(150),
    supply_type VARCHAR(150),
    PRIMARY KEY (branch_id, supplier_name),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE    
);


--corporate branch
INSERT INTO employee VALUES (100, 'David', 'Wallace', '1968-11-17', 'M', 250000, NULL, NULL);
INSERT INTO branch VALUES (1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id=1
WHERE emp_id=100;

INSERT INTO employee VALUES (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

--Scranton branch
INSERT INTO employee VALUES (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, NULL, NULL);
INSERT INTO branch VALUES (2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id=2
WHERE emp_id=102;

UPDATE employee
SET super_id=100
WHERE first_name='Michael' AND last_name='Scott';

INSERT INTO employee VALUES (103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, '102', '2');
INSERT INTO employee VALUES (104, 'Kelly', 'Kapoor', '1961-05-11', 'F', 55000, '102', '2');
INSERT INTO employee VALUES (105, 'Stanley', 'Hudson', '1961-05-11', 'M', 69000, '102', '2');

UPDATE employee
SET birth_date = '1980-02-05'
WHERE first_name='Kelly';
UPDATE employee 
SET birth_date = '1958-02-19'
WHERE last_name='Hudson';


--Stanford branch
INSERT INTO employee VALUES (106, 'Josh', 'Porter', '1969-09-06', 'M', 78000, 100, NULL);
INSERT INTO branch VALUES (3, 'Stanford', 106, '1998-02-13');

UPDATE employee
SET branch_id=3
WHERE emp_id=106;

INSERT INTO employee VALUES (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES (108, 'Jim', 'Harper', '1976-10-01', 'M', 71000, 106, 3);

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client(client_id, client_name, branch_id)
    VALUES  (400, 'Dunmore Highschool', 2),
            (401, 'Lackawana Country', 2),
            (402, 'FedEx', 3),
            (403, 'John Daly Law, LLC', 3),
            (404, 'Scranton Whitepages', 2),
            (405, 'Times Newspaper', 3),
            (406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with(emp_id, client_id, total_sales)
    VALUES
    (105, 400, 55000),
    (102, 401, 267000),
    (108, 402, 22500),
    (107, 403, 5000),
    (108, 403, 12000),
    (105, 404, 33000),
    (107, 405, 26000),
    (102, 406, 15000),
    (105, 406, 130000);

SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM branch_supplier;

--Database set up complete!!
--Basic queries

SELECT *
FROM employee
ORDER BY birth_date DESC
LIMIT 5;

SELECT COUNT (first_name) AS 'Old Geezers'
FROM employee
WHERE birth_date > '1970-12-31';

SELECT (first_name) AS 'Old Geezers', (last_name) AS 'Surname', (birth_date)
FROM employee
WHERE birth_date < '1970-12-31'
ORDER BY birth_date ASC;

SELECT DISTINCT (sex)
FROM employee;

--Aggregation
SELECT (sex), SUM(salary) AS 'sum'
FROM employee
GROUP BY sex;

--Wildcards
SELECT (branch_id), (supplier_name)
FROM branch_supplier 
WHERE supplier_name LIKE '%lab___';

SELECT *
FROM employee 
WHERE birth_date LIKE '%____-10%';

--Unions
SELECT first_name
FROM employee
UNION
SELECT branch_name
FROM branch;

--Joins
SELECT  employee.first_name, employee.emp_id, 
        client.client_id, client.client_name
FROM employee
JOIN works_with ON employee.emp_id = works_with.emp_id
JOIN client ON client.client_id = works_with.client_id
ORDER BY employee.first_name;