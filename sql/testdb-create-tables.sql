-- DROP DATABASE IF EXISTS testdb;
-- CREATE DATABASE testdb;
-- USE testdb;

CREATE TABLE User_Permissions (
	permission_id SERIAL NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (permission_id)
);

CREATE TABLE User_Roles (
	role_id SERIAL NOT NULL,
    role_name TEXT NOT NULL,
    PRIMARY KEY (role_id),
);

CREATE TABLE User_Role_Permissions (
	role_id INT NOT NULL,
	permission_id INT NOT NULL,
	PRIMARY KEY (role_id, permission_id),
	FOREIGN KEY (role_id)
		References User_Roles (role_id),
	FOREIGN KEY (permission_id)
		References User_Permissions (permission_id)
);

CREATE TABLE Departments (
	department_id SERIAL NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (department_id)
);

CREATE TABLE Sites (
	site_id SERIAL NOT NULL,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    country TEXT NOT NULL,
    zipcode TEXT NOT NULL,
    PRIMARY KEY (site_id)
);

CREATE Table Labs (
	lab_id SERIAL NOT NULL,
    name TEXT NOT NULL,
    department int NOT NULL,
    site int NOT NULL,
    PRIMARY KEY (lab_id),
    FOREIGN KEY (department)
		REFERENCES Departments (department_id),
	FOREIGN KEY (site)
		REFERENCES Sites (site_id)
);

CREATE TABLE Users (
	user_id SERIAL NOT NULL,
    employee_id int NOT NULL,
    name TEXT NOT NULL,
    password TEXT NOT NULL,
    role int NOT NULL,
    department int NOT NULL,
	PRIMARY KEY (user_id),
	FOREIGN KEY (role)
		REFERENCES User_Roles (role_id),
	FOREIGN KEY (department)
		REFERENCES Departments (department_id)
	);
    
CREATE TABLE Test_Standards (
	standard_id SERIAL NOT NULL,
    name TEXT NOT NULL,
    region TEXT NOT NULL,
    standard_owner int NOT NULL,
    PRIMARY KEY (standard_id),
    FOREIGN KEY (standard_owner)
		REFERENCES Users (user_id)
	);
    
CREATE TABLE Clients (
	client_id SERIAL NOT NULL,
	name TEXT NOT NULL,
	contact_name TEXT NOT NULL,
	address TEXT NOT NULL,
	city TEXT NOT NULL,
	state TEXT NOT NULL,
	country TEXT NOT NULL,
	zipcode VARCHAR(5) NOT NULL,
	PRIMARY KEY (client_id)
);

CREATE TABLE Projects (
	project_id SERIAL NOT NULL,
	project_name TEXT NOT NULL,
	client int NOT NULL,
	PRIMARY KEY (project_id),
	FOREIGN KEY (client)
		REFERENCES Clients (client_id)
    );
 
    
CREATE TABLE Work_Orders (
	order_id SERIAL NOT NULL,
	project int NOT NULL,
	quoted_hours int,
	worked_hours int NOT NULL,
	completion_date_estimate TEXT NOT NULL,
	PRIMARY KEY (order_id),
	FOREIGN KEY (project)
		REFERENCES Projects (project_id)
    );

CREATE TABLE Tasks (
	task_id SERIAL NOT NULL,
	name TEXT NOT NULL,
	order_id int NOT NULL,
	status TEXT NOT NULL,
	selected_fullfillment int,
	standard int NOT NULL,
	PRIMARY KEY (task_id),
	FOREIGN KEY (order_id)
		REFERENCES Work_Orders (order_id),
	FOREIGN KEY (standard)
		REFERENCES Users (user_id)
    );
    
CREATE TABLE Tests (
	test_id SERIAL NOT NULL,
    task_id int NOT NULL,
    tester int NOT NULL,
    lab int NOT NULL,
    test_date TEXT NOT NULL,
    test_result TEXT NOT NULL,
    PRIMARY KEY (test_id),
    FOREIGN KEY (task_id)
		REFERENCES Tasks (task_id),
    FOREIGN KEY (tester)
		REFERENCES Users (user_id),
	FOREIGN KEY (lab)
		REFERENCES Labs (lab_id)
);

CREATE TABLE Test_Data (
	testdata_id SERIAL NOT NULL,
    test int NOT NULL,
    type TEXT NOT NULL,
    data TEXT NOT NULL,
    PRIMARY KEY (testdata_id),
    FOREIGN KEY (test)
		REFERENCES Tests (test_id)
);

-- Constraint added in post due to dependency paradox
ALTER TABLE Tasks ADD CONSTRAINT FK_Tasks_Tests
	FOREIGN KEY (selected_fullfillment)
		REFERENCES Tests (test_id);

