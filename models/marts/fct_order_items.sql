{{
    config(
        materialized='table'
    )
}}

select
    -- Chaves
    items.order_id,
    items.product_id,
    orders.customer_unique_id,

    -- Detalhes do Item
    items.order_item_id, -- A sequência do item dentro do pedido (1, 2, 3...)
    items.item_price,
    items.freight_value,

    -- Detalhes do Produto (da dim_products)
    products.product_category_name_english,

    -- Detalhes do Pedido (da fct_orders)
    orders.purchase_timestamp,
    orders.order_status

from
    {{ ref('stg_order_items') }} as items
left join {{ ref('fct_orders') }} as orders
    on items.order_id = orders.order_id
left join {{ ref('dim_products') }} as products
    on items.product_id = products.product_id