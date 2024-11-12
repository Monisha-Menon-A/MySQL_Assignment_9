create database assignment_9;
use assignment_9;
/*Consider the Worker table with following fields: Worker_Id INT FirstName CHAR(25),
LastName CHAR(25), Salary INT(15), JoiningDate DATETIME, Department CHAR(25))*/
create table worker(worker_id int,
					 firstname char(25),
                     lastname char(25),
                     salary int,
                     joiningdate datetime,
                     department char(25));
desc worker; 
insert into worker(worker_id, firstname, lastname, salary, joiningdate, department)
values(1, 'Nithya', 'Jayaram', 20000, '2024-11-03 09:00:00', 'IT'),
(2, 'Femi', 'Azad', 21000, '02024-11-04 09:00:00', 'Accounts'),
(3, 'Divya', 'John', 19000, '2024-11-05 09:00:00', 'IT'),
(4, 'Ajay', 'Raj', 22000, '2024-11-06 09:00:00', 'Administration'),
(5, 'Sindhu', 'Suresh', 18000, '2024-11-07 09:00:00', 'IT');
select* from worker;
/*Create a stored procedure that takes in IN parameters for all the columns in the 
Worker table and adds a new record to the table and then invokes the procedure call*/
Delimiter $$
create procedure worker(in p_worker_id int,
						in p_firstname char(25),
                        in p_lastname char(25),
                        in p_salary int,
                        in p_joiningdate datetime,
                        in p_department char(25))
begin
insert into worker(worker_id, firstname, lastname, salary, joiningdate, department)
values(p_worker_id, p_firstname, p_lastname, p_salary, p_joiningdate, p_department);
end $$
Delimiter ;
call worker(6, 'Sanya', 'Ram', 20000, '2024-10-12 09:00:00', 'Accounts');
select * from worker;
/*Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY. 
It should retrieve the salary of the worker with the given ID and returns it in the 
p_salary parameter. Then make the procedure call*/
Delimiter $$
create procedure GetWorkerSalary(in n_worker_id int, out n_salary int)
begin
    select salary into n_salary from worker where worker_id = n_worker_id;
end$$
Delimiter ;
set @salary_result = 0;
call GetWorkerSalary(1, @salary_result);
select @salary_result AS WorkerSalary;
/*Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT. 
It should update the department of the worker with the given ID. Then make a procedure call*/
Delimiter $$
create procedure UpdateWorkerDepartment(in p_worker_id int, in p_new_department char(25))
begin
    update worker set department = p_new_department where worker_id = p_worker_id;
end $$
Delimiter ;
set sql_safe_updates =0;
call UpdateWorkerDepartment(3, 'Marketing');
select worker_id, department from worker where worker_id = 3;
/*Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter
for p_workerCount. It should retrieve the number of workers in the given department
and returns it in the p_workerCount parameter. Make procedure call*/
Delimiter $$
create procedure GetWorkerCountByDepartment(in p_department char(25), out p_workerCount int)
begin
    select count(*) into p_workerCount from worker where department = p_department;
end$$
Delimiter ;
set @worker_count = 0;
call GetWorkerCountByDepartment('IT', @worker_count);
select @worker_count as WorkerCount;
select * from worker;
/*Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter 
for p_avgSalary. It should retrieve the average salary of all workers in the given department
and returns it in the p_avgSalary parameter and call the procedure*/
Delimiter $$
create procedure GetAvgSalaryByDepartment(in p_department char(25), out p_avgSalary DECIMAL(10,2))
begin
    select avg(salary) into p_avgSalary from worker where department = p_department;
end$$
Delimiter ;
set @avg_salary = 0;
call GetAvgSalaryByDepartment('Accounts', @avg_salary);
select @avg_salary as AvgSalary;