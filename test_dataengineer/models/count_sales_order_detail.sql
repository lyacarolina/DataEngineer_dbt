
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
    count(SalesOrderID) as qty_lines
from
    count_order_id
where
    count_id >= 3

