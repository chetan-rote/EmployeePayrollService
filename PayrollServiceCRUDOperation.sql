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
