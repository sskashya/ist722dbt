with stg_employees as (
    select * from {{ source('fudgemart_v3', 'fm_employees')}}
)
select
{{ dbt_utils.generate_surrogate_key(['stg_employees.employee_id'])}} as employeekey, 
employee_id, 
concat(employee_firstname, ' ', employee_lastname) as employeenamefirstlast,
employee_jobtitle,
employee_department,
employee_birthdate,
employee_hiredate,
employee_termdate,
employee_hourlywage,
employee_fulltime
from stg_employees