
with sales_order_detail as (
    select 
        * 
    from 
        {{source('sources', 'salesorderdetail')}}

),

count_order_id as(
    select
        SalesOrderID,
        count(SalesOrderID) as count_id
    from
        sales_order_detail
    group BY
        SalesOrderID
)

select
    SalesOrderID,
    count_id
from
    count_order_id
where
    count_id >= 3

