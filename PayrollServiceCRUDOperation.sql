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

/*UC9 Extending table to add more columns*/
alter table Employee_Payroll Add Basic_Pay money null default 0,  Deductions money null default 0, Taxable_Pay money null default 0, Income_Tax money null default 0, Net_Pay money null default 0
sp_rename 'employee_payroll.salary', 'basic_pay';
/*UC10 Make Terissa partof sales and marketing department*/
insert into employee_payroll (name , Basic_Pay, start_date, Gender, Employee_Address, Department, Phone_Number) values
('Terissa', 200000.00, '2019-11-13', 'F', 'NewYork', 'Sales', '9999999999')


create table Employee
(
Employee_Id int identity(1,1) not null,
Name varchar(25) not null,
Start_Date date not null,
Gender varchar(10) not null,
Address varchar(100) not null,
Dept_no int not null,
Phone_Number varchar(10) not null,
PRIMARY KEY (Employee_Id)
);

insert into Employee values
('Bill','2018-01-03','M', 'Brooklyn', 1,'9876548560'),
('Terissa','2019-11-13','F', 'Manhattan', 2,'8965548560'),
('Charlie','2020-05-21','M', 'New Jersey', 3,'7548548560');

Select * from Employee

create table Department
(
Dept_no int identity(1,1) not null,
Dept_name varchar(30) not null,
Dept_location varchar(50) not null,
PRIMARY KEY (Dept_no)
);
select * from Department
insert into Department values
('Delivery','Manhattan',1),
('Sales','Boston',2),
('HR','Illinois',3);

create table Salary(
Salary_id int identity(1,1) not null,
Employee_Id int not null,
Basic_pay money not null,
Deductions money not null,
Taxable_pay money not null,
Income_tax money not null,
Net_pay money not null,
PRIMARY KEY (Salary_id),
FOREIGN KEY (Employee_Id) REFERENCES Employee(Employee_Id)
);

select * from Salary
insert into Salary values
(1,10000.00, 500.00, 500.00, 500.00,11500.00),
(2,11000.00, 500.00, 500.00, 500.00,12500.00),
(3,9000.00, 500.00, 500.00, 500.00,10500.00);


alter table Employee
Add FOREIGN KEY (Dept_no) REFERENCES Department(Dept_no);


/*UC12 Ensure all retrieve queries done on UC4, UC5 and UC7*/

/*UC4 Retrieve all records for employee*/
select emp.Employee_Id, emp.Name, emp.Start_Date, emp.Gender, emp.Address, emp.Phone_Number,
dept.Dept_no, dept.Dept_name,dept.Dept_location,
sal.Salary_id, sal.Basic_pay, sal.Deductions, sal.Taxable_pay, sal.Income_tax, sal.Net_pay
from Employee emp, Department dept, Salary sal
where emp.Employee_Id = dept.Employee_Id and sal.Employee_Id = emp.Employee_Id;

/* UC5 Retrieving all the records from the Salary table for a particular employee*/
select emp.Employee_Id, emp.Name, emp.Start_Date, emp.Gender, emp.Address, emp.Phone_Number,
sal.Salary_id, sal.Basic_pay, sal.Deductions, sal.Taxable_pay, sal.Income_tax, sal.Net_pay
from Employee emp, Salary sal
where emp.Employee_Id = sal.Employee_Id and emp.Name = 'Bill';

/* UC5 Retrieving all the records from the employee payroll table for a employee joining date between a time frame*/
select * from Employee emp, Department dept, Salary sal
where emp.Employee_Id = dept.Employee_Id and sal.Employee_Id = emp.Employee_Id and 
 emp.start_date between CAST('2018-01-01' as date) and CAST(getdate() as date);

/*UC7 Using aggregate functions */
SELECT Sum(Net_pay) 
FROM Salary INNER JOIN Employee 
ON Salary.Employee_Id=Employee.Employee_Id
WHERE Gender='M' GROUP BY Gender;

SELECT Avg(Net_pay) 
FROM Salary INNER JOIN Employee 
ON Salary.Employee_Id=Employee.Employee_Id
WHERE Gender='M' GROUP BY Gender;

SELECT Min(Net_pay) 
FROM Salary INNER JOIN Employee 
ON Salary.Employee_Id=Employee.Employee_Id
WHERE Gender='M' GROUP BY Gender;

SELECT Max(Net_pay) 
FROM Salary INNER JOIN Employee 
ON Salary.Employee_Id=Employee.Employee_Id
WHERE Gender='M' GROUP BY Gender;




