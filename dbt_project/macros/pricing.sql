{% macro format_price(column_name) %}
    ({{ column_name }})::decimal(16, 2)
{% endmacro %}