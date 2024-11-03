with stg_products as (
    select * from {{source('northwind', 'Products')}}
),
stg_suppliers as (
    select * from {{source('northwind', 'Suppliers')}}
),
stg_categories as (
    select * from {{source('northwind', 'Categories')}}
)
select
    {{dbt_utils.generate_surrogate_key(['p.productid'])}} as productkey,
    p.productid,
    p.productname,
    s.supplierid,
    c.categoryname,
    c.description
from stg_products p 
    left join stg_suppliers s on s.supplierid = p.supplierid
    left join stg_categories c on c.categoryid = p.categoryid 