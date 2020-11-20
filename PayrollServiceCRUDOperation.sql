/*UC1
Creating Payroll service database*/
create database payroll_service
use payroll_service

/*UC2 Creating table */
create table employee_payroll
(
id int identity(1,1) not null,
name varchar(25) not null,
salary money not null,
start_date date not null
)

/*UC3 Inserting Data to table*/
insert into employee_payroll values
('Bill',100000.00,'2018-01-03'),
('Terissa',200000.00,'2019-11-13'),
('Charlie',300000.00,'2020-05-21');

/*UC4 Retrieving Data from table*/
select * from employee_payroll