{# declaration of payment_types variable. Add here if a new one appears #}
{%- set payment_types = ['cash', 'credit'] -%}

WITH payments AS (
    SELECT * FROM {{ ref('base_stripe_order_payments') }}
),

pivot_and_aggregate_payments_to_order_grain AS (
    SELECT
        order_id,
        {% for payment_type in payment_types -%}
            
            
            SUM(
                CASE
                    WHEN
                        payment_type = '{{ payment_type }}'
                        AND status = 'success'
                        THEN amount
                    ELSE 0
                END
            ) AS {{ payment_type }}_amount,
        {%- endfor %}
        SUM(
            CASE
                WHEN status = 'success'
                    THEN amount
            END
        ) AS total_amount
    FROM payments

    GROUP BY 1
)

SELECT * FROM pivot_and_aggregate_payments_to_order_grain
