{% macro get_payment_types() %}
    {% set payment_type_query %}
    SELECT
        DISTINCT payment_type
    FROM {{ ref('base_stripe_order_payments') }}
    ORDER by 1
    {% endset %}

    {% set results = run_query(payment_type_query) %}

    {% if execute %}
    {# Return the first column #}
    {% set results_list = results.columns[0].values() %}
    {% else %}
    {% set results_list = [] %}
    {% endif %}

    {{ return(results_list) }}

{% endmacro %}
