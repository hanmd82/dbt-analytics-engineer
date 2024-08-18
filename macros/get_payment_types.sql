{% macro get_payment_types() %}
    {{ return(['cash', 'credit']) }}
{% endmacro %}
