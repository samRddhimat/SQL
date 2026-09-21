
-- Employees with highers salary than the department average

--using CTE
WITH deptavg as 
(select department,avg(monthly_salary) avgms from empsal group by department)

select a.name,a.department,a.monthly_salary, d.avgms as dept_avg  from empsal a
inner join deptavg d on a.department = d.department
where a. monthly_salary > d.avgms order by a.department

-- select * from empsal where department = 'HR' and monthly_salary > 82945.1428571429
--using window functions

select * from
 (select name, department,monthly_salary, 
avg(monthly_salary) over(partition by department) as dept_avg_salary from empsal
) e
where monthly_salary > dept_avg_salary 
a
