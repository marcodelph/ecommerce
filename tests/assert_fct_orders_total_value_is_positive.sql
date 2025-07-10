select
    *
from
    {{ ref('fct_orders') }}
where
    total_order_value < 0