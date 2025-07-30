-- models/marts/dim_sellers.sql

{{
    config(
        materialized='table'
    )
}}

with seller_sales as (
    select
        seller_id,
        count(order_id) as number_of_orders,
        sum(item_price) as total_revenue
    from {{ ref('stg_order_items') }}
    group by 1
)

select
    s.seller_id,
    s.seller_zip_code_prefix,
    s.seller_city,
    s.seller_state,
    coalesce(ss.number_of_orders, 0) as number_of_orders,
    coalesce(ss.total_revenue, 0) as total_revenue
from
    {{ ref('stg_sellers') }} s
left join seller_sales ss on
    s.seller_id = ss.seller_id