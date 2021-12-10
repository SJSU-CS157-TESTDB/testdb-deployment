-- views

CREATE VIEW "Work Overview" AS
	SELECT
	Projects.project_name,
	Clients.name,
	Work_Orders.order_id,
	Work_Orders.quoted_hours,
	Work_Orders.worked_hours,
	Work_Orders.completion_date_estimate
	FROM Work_Orders
	INNER JOIN Projects ON Work_Orders.project=Projects.project_id
	INNER JOIN Clients ON Projects.client=Clients.client_id;

CREATE VIEW "Work Orders Over Budget" AS
	SELECT
	Projects.project_name,
	Work_Orders.order_id,
	Work_Orders.quoted_hours,
	Work_Orders.worked_hours
	FROM Work_Orders
	INNER JOIN Projects ON Work_Orders.project=Projects.project_id
	WHERE Work_Orders.worked_hours > Work_Orders.quoted_hours;

CREATE VIEW "Unreviewed Test Data" AS
	SELECT
	Tasks.task_id,
	Tasks.name,
	Projects.project_name,
	Tasks.order_id,
	Tasks.name
	FROM Tasks
	INNER JOIN Work_Orders ON Tasks.order_id=Work_Orders.order_id
	INNER JOIN Projects ON Work_Orders.project=Projects.project_id
	WHERE Tasks.status = 'Tested';