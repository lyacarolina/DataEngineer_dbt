with person as (
    select 
        * 
    from 
        {{source('sources', 'person')}}

),

customer as (
    select 
        * 
    from 
        {{source('sources', 'customer')}}

),

sales_order_header as (
    select 
        * 
    from 
        {{source('sources', 'salesorderheader')}}

),

concat_person as (
    select
        BusinessEntityID,
        concat(
            FirstName,
            LastName
        ) as name_complete
    from
        person

),

joined_tables as (
    select
        concat_person.name_complete,
        concat_person.BusinessEntityID,
        sales_order_header.SalesOrderID,
        sales_order_header.CustomerID,
        customer.CustomerID,
        customer.PersonID
    from
        customer
    left join
        concat_person on
            concat_person.BusinessEntityID = customer.PersonID
    left join
        sales_order_header on
            sales_order_header.CustomerID = customer.CustomerID
    group by 
        concat_person.name_complete,
        concat_person.BusinessEntityID,
        customer.PersonID,
        customer.CustomerID,
        sales_order_header.CustomerID,
        sales_order_header.SalesOrderID
)



select
    name_complete,
    BusinessEntityID,
    count(SalesOrderID) as count_orders
from 
    joined_tables
group by
    name_complete,
    BusinessEntityID
    

