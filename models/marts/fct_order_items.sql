-- models/marts/fct_order_items.sql

{{
    config(
        materialized='table'
    )
}}

select
    -- Chaves
    items.order_id,
    items.product_id,
    items.seller_id,
    cust.customer_unique_id,

    -- Detalhes do Item
    items.order_item_id,
    items.item_price,
    items.freight_value,

    -- Detalhes do Pedido
    ord.purchase_timestamp::date as purchase_date,
    ord.order_status

from
    {{ ref('stg_order_items') }} as items
left join {{ ref('stg_orders') }} as ord
    on items.order_id = ord.order_id
left join {{ ref('stg_customers') }} as cust
    on ord.customer_id = cust.customer_id