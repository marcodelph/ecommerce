select
    *
from
    {{ ref('fct_orders') }}
where
    total_order_value < 0

    -- teste sucesso = retorno de 0 linhas