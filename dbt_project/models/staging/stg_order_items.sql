select
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    {{ format_price('price') }} as item_price,
    {{ format_price('freight_value') }} as freight_value
from {{ source('olist_ecommerce', 'olist_order_items_dataset') }}