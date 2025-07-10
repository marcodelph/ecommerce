select
    c.customer_unique_id,
    min(o.purchase_timestamp) as first_order_date,
    max(o.purchase_timestamp) as most_recent_order_date,
    count(o.order_id) as number_of_orders,
    sum(f.total_order_value) as total_value_spent
from
    dbt_ecommerce.stg_customers as c
left join dbt_ecommerce.stg_orders as o
    on c.customer_id = o.customer_id
left join dbt_ecommerce.fct_orders as f
    on o.order_id = f.order_id
group by
    c.customer_unique_id;
