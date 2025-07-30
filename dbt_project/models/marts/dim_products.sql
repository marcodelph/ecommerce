-- models/marts/dim_products.sql

{{
    config(
        materialized='table'
    )
}}

with product_sales as (
    select
        product_id,
        count(order_id) as number_of_orders,
        sum(item_price) as total_revenue
    from {{ ref('stg_order_items') }}
    group by 1
)

select
    p.product_id,
    p.product_category_name,
    t.product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,
    coalesce(ps.number_of_orders, 0) as number_of_orders,
    coalesce(ps.total_revenue, 0) as total_revenue
from
    {{ ref('stg_products') }} p
left join {{ ref('stg_product_category_name_translation') }} t on
    p.product_category_name = t.product_category_name
left join product_sales ps on
    p.product_id = ps.product_id