-- Agregar os itens de pedido para calcular o total por pedido
with order_items as (
    select
        order_id,
        sum(item_price) as total_item_price,
        sum(freight_value) as total_freight_value
    from {{ ref('stg_order_items') }}
    group by 1
),


final as (
    select
        -- Chaves
        orders.order_id,
        orders.customer_id,

        -- Timestamps
        orders.purchase_timestamp,
        orders.approved_at_timestamp,

        -- Status
        orders.order_status,

        -- Métricas do pedido
        order_items.total_item_price,
        order_items.total_freight_value,
        (order_items.total_item_price + order_items.total_freight_value) as total_order_value

    from {{ ref('stg_orders') }} as orders

    left join order_items on orders.order_id = order_items.order_id
)

select * from final