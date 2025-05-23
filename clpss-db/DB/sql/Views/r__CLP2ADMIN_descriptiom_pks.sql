DECLARE
	TYPE broker_user_rec IS RECORD
	(
		user_id company_id branch_id
		simdata. employee.userid%TYPE, simdata. employee.companyid%TYPE, simdata.employee.branchid%TYPE
	);
	
	TYPE broker_users_t IS TABLE OF broker_user_rec
		INDEX BY BINARY_INTEGER;

	broker_users         broker_user 
	broker_employee_id   row_count
	
	
	
	BEGIN
	broker_users_t; broker_user_rec;
	simdata.employee.employeeid%TYPE;
NUMBER (9, 0);
broker_user.user_id := 'BCIWANG' ; broker_user.company_id := 'G'; broker_user.branch_id := 'K';
broker_users (1) := broker_user;
FOR i IN broker_users. FIRST .. broker_users. LAST LOOP SELECT COUNT (*)
INTO row_count
FROM simdata.employee
WHERE userid = broker_users (i).user_id;
IF (row_count = 1)
THEN
SELECT employeeid
INTO broker_employee_id
FROM simdata.employee
WHERE userid - broker_users (i).user_id;
IF broker_employee_id IS NOT NULL
THEN
UPDATE simdata. employee
SET companyid = broker_users (i). company_id,
branchid - broker_users (i).branch_id
WHERE employeeid = broker_employee_id;
END IF;
END IF;
END LOOP;
