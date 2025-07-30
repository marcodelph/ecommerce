-- models/marts/dim_customers.sql

{{
    config(
        materialized='table'
    )
}}

with customer_orders as (
    select
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        o.order_id,
        o.purchase_timestamp,
        row_number() over (partition by c.customer_unique_id order by o.purchase_timestamp desc) as order_rank
    from {{ ref('stg_customers') }} as c
    left join {{ ref('stg_orders') }} as o on c.customer_id = o.customer_id
),

order_values as (
    select
        order_id,
        sum(item_price + freight_value) as total_order_value
    from {{ ref('stg_order_items') }}
    group by 1
),

final as (
    select
        co.customer_unique_id,
        
        max(case when co.order_rank = 1 then co.customer_city end) as most_recent_city,
        max(case when co.order_rank = 1 then co.customer_state end) as most_recent_state,
        
        min(co.purchase_timestamp) as first_order_date,
        max(co.purchase_timestamp) as most_recent_order_date,
        datediff('day', max(co.purchase_timestamp), current_date()) as days_since_last_order, 
        
        count(distinct co.order_id) as number_of_orders, 
        
        coalesce(sum(ov.total_order_value), 0) as total_value_spent, 
        
        coalesce(sum(ov.total_order_value) / nullif(count(distinct co.order_id), 0), 0) as average_order_value -- AOV

    from customer_orders as co
    left join order_values as ov on co.order_id = ov.order_id
    group by 1
)

select * from final