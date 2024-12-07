with stg_jobtitles as (
    select * from {{source('fudgemart_v3', 'fm_jobtitles_lookup')}}
),
stg_employees as (
    select * from {{source('fudgemart_v3', 'fm_employees')}}
)
select
{{dbt_utils.generate_surrogate_key(['j.jobtitle_id'])}} as jobtitlekey,
j.jobtitle_id,
e.employee_id,
e.employee_jobtitle
from stg_jobtitles as j
    left join stg_employees e on j.jobtitle_id = e.employee_jobtitle


