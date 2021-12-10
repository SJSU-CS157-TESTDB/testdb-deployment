

INSERT INTO User_Permissions (name)
VALUES 
    ('Full Access'), ('Submit Test Data'), ('Review Test Data'), 
    ('Compile Report'), ('Create/Edit Standards'), ('Read Standards'),
    ('Create Projects'), ('Create Work Orders'), ('Review Report'),
    ('View Business Insights'), ('Schedule Test Dates');


INSERT INTO User_Roles (role_name)
VALUES
    ('Administrator'), ('Project Manager'), ('Test Staff'), 
    ('Test Review Staff'), ('Report Writer'), ('Standard Owner'), 
    ('Sales Representative');

INSERT INTO User_Role_Permissions (role_id, permission_id)
VALUES
    (1,1), -- admin
    (2,6),(2,7),(2,8),(2,9),(2,10), -- pm
    (3,2),(3,6), -- test staff
    (4,6),(4,3), -- test review staff
    (5,6),(5,4), -- report writer
    (6,6),(6,5), -- standard owner
    (7,6),(7,8),(7,10); -- sales rep


INSERT INTO Departments (name)
VALUES
    ('RF'), ('SAR'), ('Sales'), ('Management'), ('Technical');


INSERT INTO Sites (name, address, city, state, country, zipcode)
VALUES
    ('Site 1', '123 Main Street', 'Anytown', 'CA', 'USA', '12345'),
    ('Site 2', '456 Main Street', 'Anytown', 'CA', 'USA', '12345'),
    ('Site 3', '789 Main Street', 'Anytown', 'CA', 'USA', '12345');

INSERT INTO Labs (name, department, site)
VALUES
    ('RF Lab 1', 6, 4),
    ('RF Lab 2', 6, 5),
    ('RF Lab 3', 6, 6),
    ('SAR Lab 4', 7, 4),
    ('SAR Lab 5', 7, 5),
    ('SAR Lab 6', 7, 6);


INSERT INTO Users (employee_id, name, password, role, department)
VALUES
    ('12345', 'John Smith', 'password', 1, 6),
    ('23456', 'Jane Smith', 'password', 2, 7),
    ('34567', 'Joe Smith', 'password', 3, 8),
    ('45678', 'John Doe', 'password', 4, 9),
    ('56789', 'Jane Doe', 'password', 5, 10),
    ('67890', 'Joe Doe', 'password', 6, 6);


INSERT INTO Test_Standards (name, region, standard_owner)
VALUES
    ('802.11', 'RF', 16),
    ('LTE', 'RF', 16);


INSERT INTO Clients (name, contact_name, address, city, state, country, zipcode)
VALUES
    ('Client 1', 'John Smith', '123 Main Street', 'Anytown', 'CA', 'USA', '12345'),
    ('Client 2', 'Jane Smith', '456 Main Street', 'Anytown', 'CA', 'USA', '12345'),
    ('Client 3', 'Joe Smith', '789 Main Street', 'Anytown', 'CA', 'USA', '12345');


INSERT INTO Projects (project_name, client)
VALUES
    ('Project 1', 1),
    ('Project 2', 2),
    ('Project 3', 3);

INSERT INTO Work_Orders (project, quoted_hours, worked_hours, completion_date_estimate)
VALUES
    (1, 100, 50, '2022-02-11'),
    (2, 100, 101, '2021-12-30'),
    (3, 100, 200, '2022-01-01');

INSERT INTO Tasks(name, order_id, status, standard)
VALUES
    ('Task 1', 1, 'Tested', 3),
    ('Task 2', 1, 'Tested', 3),
    ('Task 3', 1, 'Tested', 3),
    ('Task 4', 1, 'Tested', 3),
    ('Task 5', 1, 'Tested', 3),
    ('Task 6', 1, 'Tested', 3),
    ('Task 7', 1, 'Tested', 3),
    ('Task 8', 1, 'Tested', 3),
    ('Task 9', 1, 'Tested', 3),
    ('Task 10', 1, 'Open', 3),
    ('Task 11', 1, 'Open', 3),
    ('Task 12', 2, 'Open', 3),
    ('Task 13', 2, 'Open', 3),
    ('Task 14', 2, 'Open', 3),
    ('Task 15', 2, 'Open', 3),
    ('Task 16', 2, 'Open', 3),
    ('Task 17', 2, 'Open', 3),
    ('Task 18', 2, 'Open', 3),
    ('Task 19', 1, 'Open', 3),
    ('Task 20', 1, 'Open', 3),
    ('Task 21', 1, 'Open', 3),
    ('Task 22', 1, 'Open', 3),
    ('Task 23', 1, 'Open', 3),
    ('Task 24', 1, 'Open', 3),
    ('Task 25', 1, 'Reviewed', 4),
    ('Task 26', 1, 'Reviewed', 4),
    ('Task 27', 1, 'Reviewed', 4),
    ('Task 28', 1, 'Reviewed', 4),
    ('Task 29', 1, 'Reviewed', 4),
    ('Task 30', 1, 'Reviewed', 4),
    ('Task 31', 1, 'Reviewed', 4),
    ('Task 32', 1, 'Reviewed', 4),
    ('Task 33', 1, 'Finalized', 4),
    ('Task 34', 1, 'Finalized', 4),
    ('Task 35', 1, 'Finalized', 4),
    ('Task 36', 1, 'Finalized', 4),
    ('Task 37', 1, 'Finalized', 4),
    ('Task 38', 1, 'Finalized', 4);


INSERT INTO Tests (task_id, tester, lab, test_date, test_result)
VALUES
    (77, 13, 19, '2021-1-1', 'Passed'),
    (78, 13, 19, '2021-1-1', 'Failed'),
    (79, 13, 19, '2021-1-1', 'Passed'),
    (80, 13, 19, '2021-1-1', 'Passed'),
    (81, 13, 19, '2021-1-1', 'Passed'),
    (82, 13, 20, '2021-1-1', 'Passed'),
    (83, 13, 20, '2021-1-1', 'Passed'),
    (84, 13, 20, '2021-1-1', 'Passed'),
    (85, 13, 20, '2021-1-1', 'Passed'),
    (86, 13, 20, '2021-1-1', 'Passed');

INSERT INTO Test_Data (test, type, data)
VALUES
    (191, 'spectrum_plot_url', 'https://rfmw.em.keysight.com/rfcomms/refdocs/wcdma/wcdma_meas_spec_em_mask_desc-1.gif'),
    (192, 'dbm_scalar', '16.7'),
    (193, 'dbm_scalar', '16.5'),
    (194, 'dbm_scalar', '15.5'),
    (195, 'dbm_scalar', '21.5'),
    (196, 'dbm_scalar', '20.5'),
    (197, 'dbm_scalar', '18.5'),
    (198, 'dbm_scalar', '17.2'),
    (199, 'dbm_scalar', '16.5');