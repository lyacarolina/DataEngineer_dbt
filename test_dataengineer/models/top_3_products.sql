with sales_order_detail as (
    select 
        * 
    from 
        {{source('sources', 'salesorderdetail')}}

),

special_offer_product as (
    select 
        * 
    from 
        {{source('sources', 'specialofferproduct')}}

),

product as (
    select 
        * 
    from 
        {{source('sources', 'product')}}

),

joined_tables as (
    select
        product.ProductID,
        product.name, 
        product.DaysToManufacture, 
        sum(sales_order_detail.OrderQty) as sum_order_qty
    from
        sales_order_detail
    
    left join
        product on
            product.ProductID = sales_order_detail.ProductID
    left join
        special_offer_product on 
            product.ProductID = special_offer_product.ProductID
    group BY
        product.name,
        product.ProductID,
        product.DaysToManufacture
        

)

select
    name,
    sum_order_qty
from
    joined_tables
order by 
    sum_order_qty desc
limit 3







