--second highest salary departmentwise
with dept_sal_rank as (
select	 name,department, monthly_salary,
dense_rank() over(partition by department  order by monthly_salary desc )  sal_rnk from empsal
)

select * from dept_sal_rank where sal_rnk = 2

--secod highest salary organisation-wide

select	 name,department, monthly_salary,
dense_rank() over(order by monthly_salary desc )  sal_rnk from empsal
