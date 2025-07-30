-- models/staging/stg_products.sql

with source as (
    select
        *,
        -- Mesma lógica de ranking para as duplicatas de produto
        row_number() over (partition by product_id) as rn
    from {{ source('olist_ecommerce', 'olist_products_dataset') }}
)

select
    -- Selecionamos todas as colunas, exceto a de ranking
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
from source
where rn = 1