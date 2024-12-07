with stg_dates as (
    select 
    {{dbt_utils.generate_surrogate_key(['employee_id'])}} as employeekey,
    employee_id,
    employee_hourlywage,
    replace(to_date(employee_birthdate)::varchar,'-', '')::int as birthdatekey,
    replace(to_date(employee_hiredate)::varchar,'-', '')::int as hiredatekey,
    replace(to_date(employee_termdate)::varchar,'-', '')::int as termdatekey
    from {{source('fudgemart_v3', 'fm_employees')}}
)
select 
dates.*,
DATEDIFF(YEAR, TO_DATE(CAST(dates.birthdatekey AS varchar), 'YYYYMMDD'), GETDATE()) as age,
dates.employee_hourlywage * 40 * 52 as annualsalary,
case when dates.termdatekey is null then DATEDIFF(YEAR, TO_DATE(CAST(dates.hiredatekey AS varchar), 'YYYYMMDD'), GETDATE()) else DATEDIFF(YEAR, TO_DATE(CAST(dates.hiredatekey AS varchar), 'YYYYMMDD'), TO_DATE(CAST(dates.termdatekey AS varchar), 'YYYYMMDD')) end as employeetenure
from stg_dates as dates 
