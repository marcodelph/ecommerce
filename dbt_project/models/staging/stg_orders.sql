-- models/staging/stg_orders.sql

with source as (
    select
        *,
        -- Adicionamos um ranking para cada order_id, a duplicata terá rank > 1
        row_number() over (partition by order_id order by order_purchase_timestamp desc) as rn
    from {{ source('olist_ecommerce', 'olist_orders_dataset') }}
)

select
    -- Selecionamos todas as colunas, exceto a de ranking
    order_id,
    customer_id,
    order_status,
    purchase_timestamp, -- Renomeado na fct_orders
    approved_at_timestamp,
    delivered_to_carrier_timestamp,
    delivered_to_customer_timestamp,
    estimated_delivery_timestamp
from source
where rn = 1 -- Filtramos para pegar apenas a primeira ocorrência (a mais recente)