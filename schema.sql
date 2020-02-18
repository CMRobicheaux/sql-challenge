CREATE TABLE Dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_Dept_emp PRIMARY KEY (emp_no,dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees (emp_no)
);

CREATE TABLE Departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (dept_no)
    FOREIGN KEY (dept_no) REFERENCES Dept_Manager (dept_no)
);

CREATE TABLE Employees (
    emp_no INT   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (emp_no)
);

CREATE TABLE Titles (
    emp_no INT   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (emp_no,from_date)
    FOREIGN KEY (emp_no) REFERENCES Employees (emp_no)
);

CREATE TABLE Dept_Manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    --CONSTRAINT pk_Dept_Manager PRIMARY KEY (dept_no),
    FOREIGN KEY (dept_no) REFERENCES Departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees (emp_no)
);


CREATE TABLE Salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (emp_no)
    FOREIGN KEY (emp_no) REFERENCES Employees (emp_no)
);

--List the following details of each employee: employee number, last name, first name, gender, and salary.

select employees.emp_no,
		employees.last_name,
		employees.first_name,
		employees.gender,
		salaries.salary
from employees
join salaries on salaries.emp_no = employees.emp_no;


--List employees who were hired in 1986.

select employees.emp_no,
		employees.first_name,
		employees.last_name
from employees 
where extract(year from hire_date) = 1986;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

select d.dept_no,
		d.dept_name,
		dm.emp_no,
		e.last_name,
		e.first_name,
		dm.from_date,
		dm.to_date
from employees e
join dept_manager dm on dm.emp_no = e.emp_no
join departments d on d.dept_no = dm.dept_no
;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

select d.dept_name,
		de.emp_no,
		e.first_name,
		e.last_name
from employees e
join dept_emp de on de.emp_no = e.emp_no
join departments d on d.dept_no = de.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."

select *
from employees e
where e.first_name = 'Hercules'
and e.last_name like 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

select de.emp_no,
		e.last_name,
		e.first_name,
		d.dept_name
from employees e
join dept_emp de on de.emp_no = e.emp_no
join departments d on d.dept_no = de.dept_no
where dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select de.emp_no,
		e.last_name,
		e.first_name,
		d.dept_name
from employees e
join dept_emp de on de.emp_no = e.emp_no
join departments d on d.dept_no = de.dept_no
where dept_name in ('Sales','Development');

--in descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

 select e.last_name,
 		count(*)
 from employees e
 group by last_name
 order by count desc