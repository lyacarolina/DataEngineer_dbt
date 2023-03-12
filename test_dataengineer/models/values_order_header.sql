with sales_order_header as (
    select 
        * 
    from 
        {{source('sources', 'salesorderheader')}}

),

order_september_2011 as (
    select
        SalesOrderID as sales_order_id,
        OrderDate as order_date,
        cast(replace(TotalDue, ',', '.') as decimal) as total_due
    from
       sales_order_header
    where 
        OrderDate like '2011-11-%'
),

final as (
    select
        sales_order_id,
        order_date,
        total_due as total_due
    from
       order_september_2011 
    where 
         total_due > '1000'
)

select
    *
from
    final
order by
    total_due desc

