with stg_orders as 
( 
    select 
        OrderID, 
        {{dbt_utils.generate_surrogate_key(['employeeid'])}} as employeekey,
        {{dbt_utils.generate_surrogate_key(['customerid'])}} as customerkey,
        replace(to_date(orderdate)::varchar,'-','')::int as orderdatekey
    from {{source('northwind', 'Orders')}}
),
stg_order_details as 
(
    select
        orderid,
        productid,
        sum(Quantity) as quantity,
        sum(Quantity*UnitPrice) as extendedpriceamount,
        sum(Quantity*UnitPrice*Discount) as discountamount
    from {{source('northwind', 'Order_Details')}}
    group by orderid, productid
),
stg_products as (
    select 
        productid,
        {{dbt_utils.generate_surrogate_key(['productid'])}} as productkey
    from {{source('northwind', 'Products')}}
)
select
    o.*,
    p.productkey, 
    od.quantity, od.extendedpriceamount,
    od.discountamount, od.extendedpriceamount - od.discountamount as soldamount
from stg_orders o
    join stg_order_details od on o.orderid = od.orderid
    join stg_products p on p.productid = od.productid