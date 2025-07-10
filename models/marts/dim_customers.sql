-- dim_customers.sql (Sua versão)
-- dim_customers.sql (Versão Corrigida)
with customer_orders as (
    select
        c.customer_unique_id,
        o.order_id,
        o.purchase_timestamp
    from {{ ref('stg_customers') }} as c
    left join {{ ref('stg_orders') }} as o on c.customer_id = o.customer_id
),

order_values as (
    select
        order_id,
        sum(item_price + freight_value) as total_order_value
    from {{ ref('stg_order_items') }}
    group by 1
)

select
    co.customer_unique_id,
    min(co.purchase_timestamp) as first_order_date,
    max(co.purchase_timestamp) as most_recent_order_date,
    count(co.order_id) as number_of_orders,
    sum(ov.total_order_value) as total_value_spent
from customer_orders as co
left join order_values as ov on co.order_id = ov.order_id
group by 1;