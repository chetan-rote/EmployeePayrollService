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

/*UC5 Retrieve values based on conditions*/
select salary from employee_payroll where name = 'Bill'
select * from employee_payroll where start_date between CAST('2018-01-01' as date) AND SYSDATETIME()

/*UC6 Adding column and updating rows.*/
Alter table employee_payroll add Gender char;

Update employee_payroll set gender = 'M' where name = 'Bill' or name = 'Charlie';
Update employee_payroll set gender = 'F' where name = 'Terissa';

/*UC7 Using aggregate functions on data*/
select gender,SUM(salary) as sum from employee_payroll group by gender;
select gender,AVG(salary) as avg from employee_payroll group by gender;
select gender,MIN(salary) as min from employee_payroll group by gender;
select gender,MAX(salary) as max from employee_payroll group by gender;
select gender,COUNT(gender) as count from employee_payroll group by gender;

/*UC8 Adding More Columns to table*/
Alter table Employee_Payroll Add Employee_Address varchar(200), Department Varchar(50), Phone_Number Varchar(12)
Update employee_payroll set Employee_Address = 'Brooklyn', Department = 'Sales',Phone_Number = '888888888' where name = 'Bill'
Update employee_payroll set Employee_Address = 'Boston', Department = 'Marketing',Phone_Number = '999999999' where name = 'Terissa'
Update employee_payroll set Employee_Address = 'Arizona', Department = 'Finance',Phone_Number = '777777777'  where name = 'Charlie'