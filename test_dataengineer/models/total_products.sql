with sales_order_header as (
    select 
        * 
    from 
        {{source('sources', 'salesorderheader')}}

),

sales_order_detail as (
    select 
        * 
    from 
        {{source('sources', 'salesorderdetail')}}

),

product as (
    select 
        * 
    from 
        {{source('sources', 'product')}}

),


joined_tables as(
    select
        cast(sales_order_header.OrderDate as date) as order_date,
        sales_order_detail.ProductID as product_id,
        sales_order_detail.OrderQty as order_qty
    from
        sales_order_detail
    left join
        sales_order_header on
            sales_order_header.SalesOrderID = sales_order_detail.SalesOrderID
    left join
        product on
            product.ProductID = sales_order_detail.ProductID
    group by   
        sales_order_detail.ProductID,
        sales_order_header.OrderDate,
        sales_order_detail.OrderQty
)

select
    product_id, 
    order_date,
    sum(order_qty) as sum_order_qty
from
    joined_tables
group by
    product_id,
    order_date
order by 
    product_id,
    order_date





