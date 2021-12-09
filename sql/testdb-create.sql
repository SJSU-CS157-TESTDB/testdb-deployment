-- DROP DATABASE IF EXISTS testdb;
-- CREATE DATABASE testdb;
-- USE testdb;

CREATE TABLE User_Permission (
	permission_id int NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    PRIMARY KEY (permission_id)
);

CREATE TABLE User_Role (
	role_id int NOT NULL AUTO_INCREMENT,
    role_name TEXT NOT NULL,
    permissions int NOT NULL,
    PRIMARY KEY (role_id),
    FOREIGN KEY (permissions)
		References User_Permission (permission_id)
);

CREATE TABLE Department (
	department_id int NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    PRIMARY KEY (department_id)
);

CREATE TABLE Site (
	site_id int NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    country TEXT NOT NULL,
    zipcode TEXT NOT NULL,
    PRIMARY KEY (site_id)
);

CREATE Table Lab (
	lab_id int NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    department int NOT NULL,
    site int NOT NULL,
    PRIMARY KEY (lab_id),
    FOREIGN KEY (department)
		REFERENCES Department (department_id),
	FOREIGN KEY (site)
		REFERENCES Site (site_id)
);

CREATE TABLE User (
	user_id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL,
    name TEXT NOT NULL,
    password TEXT NOT NULL,
    role int NOT NULL,
    department int NOT NULL,
	PRIMARY KEY (user_id),
	FOREIGN KEY (role)
		REFERENCES User_Role (role_id),
	FOREIGN KEY (department)
		REFERENCES Department (department_id)
	);
    
CREATE TABLE Test_Standard (
	standard_id int NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    region TEXT NOT NULL,
    standard_owner int NOT NULL,
    PRIMARY KEY (standard_id),
    FOREIGN KEY (standard_owner)
		REFERENCES User (user_id)
	);
    
CREATE TABLE Client (
	client_id int NOT NULL AUTO_INCREMENT,
	name TEXT NOT NULL,
	contact_name TEXT NOT NULL,
	address TEXT NOT NULL,
	city TEXT NOT NULL,
	state TEXT NOT NULL,
	country TEXT NOT NULL,
	zipcode VARCHAR(5) NOT NULL,
	PRIMARY KEY (client_id)
);

CREATE TABLE Project (
	project_id int NOT NULL AUTO_INCREMENT,
	project_name TEXT NOT NULL,
	client int NOT NULL,
	PRIMARY KEY (project_id),
	FOREIGN KEY (client)
		REFERENCES Client (client_id)
    );
 
    
CREATE TABLE Work_Order (
	order_id int NOT NULL AUTO_INCREMENT,
	project int NOT NULL,
	quoted_hours int,
	worked_hours int NOT NULL,
	completion_date_estimate TEXT NOT NULL,
	PRIMARY KEY (order_id),
	FOREIGN KEY (project)
		REFERENCES Project (project_id)
    );

CREATE TABLE Task (
	task_id int NOT NULL AUTO_INCREMENT,
	name TEXT NOT NULL,
	order_id int NOT NULL,
	status TEXT NOT NULL,
	selected_fullfillment int NOT NULL,
	standard int NOT NULL,
	PRIMARY KEY (task_id),
	FOREIGN KEY (order_id)
		REFERENCES Work_Order (order_id),
	FOREIGN KEY (standard)
		REFERENCES User (user_id)
    );
    
CREATE TABLE Test (
	test_id int NOT NULL AUTO_INCREMENT,
    task_id int NOT NULL,
    tester int NOT NULL,
    lab int NOT NULL,
    test_date TEXT NOT NULL,
    test_result TEXT NOT NULL,
    PRIMARY KEY (test_id),
    FOREIGN KEY (task_id)
		REFERENCES Task (task_id),
    FOREIGN KEY (tester)
		REFERENCES User (user_id),
	FOREIGN KEY (lab)
		REFERENCES Lab (lab_id)
);

CREATE TABLE Test_Data (
	testdata_id int NOT NULL AUTO_INCREMENT,
    test int NOT NULL,
    type TEXT NOT NULL,
    data TEXT NOT NULL,
    PRIMARY KEY (testdata_id),
    FOREIGN KEY (test)
		REFERENCES Test (test_id)
);

-- views

CREATE VIEW [Work Orders Over Budget] AS
	SELECT
	Project.project_name,
	Orders.order_id,
	Orders.quoted_hours,
	Orders.worked_hours,
	FROM Work_Order
	INNER JOIN Project ON Work_Order.project=Project.project_id
	WHERE Orders.worked_hours > Orders.quoted_hours;