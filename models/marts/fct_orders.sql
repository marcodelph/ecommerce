{{
    config(
        materialized='table'
    )
}}


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
        customers.customer_unique_id, 
        orders.order_id,
        orders.purchase_timestamp::date as purchase_date,
        orders.approved_at_timestamp,
        orders.order_status,
        orders.delivered_to_carrier_timestamp, -- Data de envio para a transportadora
        orders.delivered_to_customer_timestamp, -- Data de entrega ao cliente
        orders.estimated_delivery_timestamp,  -- Data estimada de entrega
        order_items.total_item_price,
        order_items.total_freight_value,
        (order_items.total_item_price + order_items.total_freight_value) as total_order_value
    from {{ ref('stg_orders') }} as orders
    left join order_items on orders.order_id = order_items.order_id
    left join {{ ref('stg_customers') }} as customers on orders.customer_id = customers.customer_id
)

select * from final