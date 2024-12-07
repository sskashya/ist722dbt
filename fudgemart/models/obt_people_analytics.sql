with f_people_analytics as (
    select * from {{ref('fact_people_analytics')}}
),
d_employee as (
    select * from {{ref('dim_employees')}}
),
d_date as (
    select * from {{ref('dim_date')}}
)
select 
d_employee.employeekey,
d_employee.employee_id,
d_employee.employeenamefirstlast,
d_employee.employee_department,
d_employee.employee_jobtitle,
d_date.*,
f_people_analytics.annualsalary,
f_people_analytics.age,
f_people_analytics.birthdatekey,
f_people_analytics.hiredatekey,
f_people_analytics.termdatekey,
f_people_analytics.employeetenure
from f_people_analytics
    left join d_employee on f_people_analytics.employeekey = d_employee.employeekey 
    left join d_date on f_people_analytics.birthdatekey = d_date.datekey