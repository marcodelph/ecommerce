-- models/staging/stg_product_category_name_translation.sql

with source as (
    select
        *,
        row_number() over (partition by product_category_name order by product_category_name) as rn
    from {{ source('olist_ecommerce', 'product_category_name_translation') }}
)

select
    product_category_name,
    product_category_name_english
from source
where rn = 1