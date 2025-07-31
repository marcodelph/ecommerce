-- models/staging/stg_customers.sql

with source as (
    select
        *,
        row_number() over (partition by customer_id order by customer_id) as rn
    from {{ source('olist_ecommerce', 'olist_customers_dataset') }}
)

select
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
from source
where rn = 1