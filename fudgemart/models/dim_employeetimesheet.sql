with stg_employeetimesheet as (
    select * from {{source('fudgemart_v3', 'fm_employee_timesheets')}}
)
select
{{dbt_utils.generate_surrogate_key(['timesheet_id'])}} as timesheetkey,
timesheet_id,
timesheet_employee_id,
timesheet_hourlyrate
from stg_employeetimesheet