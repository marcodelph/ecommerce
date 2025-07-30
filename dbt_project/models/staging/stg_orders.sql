select
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp as purchase_timestamp,
    order_approved_at as approved_at_timestamp,
    order_delivered_carrier_date as delivered_to_carrier_timestamp,
    order_delivered_customer_date as delivered_to_customer_timestamp,
    order_estimated_delivery_date as estimated_delivery_timestamp

from {{ source('olist_ecommerce', 'olist_orders_dataset') }}