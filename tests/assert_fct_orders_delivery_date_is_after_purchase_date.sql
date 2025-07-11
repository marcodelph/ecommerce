select
    *
from
    {{ ref('fct_orders') }}
where
    delivered_to_customer_timestamp < purchase_date