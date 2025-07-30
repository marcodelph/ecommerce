-- models/marts/dim_customers.sql

with customer_orders as (
    -- Junta clientes e pedidos para ter o unique_id em cada pedido
    select
        c.customer_unique_id,
        o.order_id,
        o.purchase_timestamp
    from {{ ref('stg_orders') }} as o
    left join {{ ref('stg_customers') }} as c on o.customer_id = c.customer_id
),

order_values as (
    -- Calcula o valor total de cada pedido a partir dos itens
    select
        order_id,
        sum(item_price + freight_value) as total_order_value
    from {{ ref('stg_order_items') }}
    group by 1
)

-- Agrega tudo por cliente único
select
    co.customer_unique_id,
    min(co.purchase_timestamp) as first_order_date,
    max(co.purchase_timestamp) as most_recent_order_date,
    count(co.order_id) as number_of_orders,
    sum(ov.total_order_value) as total_value_spent
from
    customer_orders as co
left join order_values as ov
    on co.order_id = ov.order_id
group by
    1 -- Agrupando por customer_unique_id