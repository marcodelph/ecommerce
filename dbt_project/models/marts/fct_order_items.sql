-- models/marts/fct_order_items.sql (Versão Final e Resiliente)

{{
    config(
        materialized='table'
    )
}}

select
    -- Chaves (garantindo a integridade a partir de stg_orders)
    ord.order_id,
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
    {{ ref('stg_orders') }} as ord
inner join {{ ref('stg_order_items') }} as items
    on ord.order_id = items.order_id
left join {{ ref('stg_customers') }} as cust
    on ord.customer_id = cust.customer_id