with stg_departments as (
    select * from {{source('fudgemart_v3', 'fm_departments_lookup')}}
),
stg_employees as (
    select * from {{source('fudgemart_v3', 'fm_employees')}}
)
select
{{dbt_utils.generate_surrogate_key(['d.department_id'])}} as departmentkey,
d.department_id,
e.employee_id,
e.employee_department
from stg_departments as d
    left join stg_employees e on d.department_id = e.employee_department


