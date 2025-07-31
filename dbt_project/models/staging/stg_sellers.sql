-- models/staging/stg_sellers.sql

with source as (
    select
        *,
        row_number() over (partition by seller_id order by seller_id) as rn
    from {{ source('olist_ecommerce', 'olist_sellers_dataset') }}
)

select
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
from source
where rn = 1