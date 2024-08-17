WITH customers AS (
    SELECT * FROM {{ ref('base_jaffle_shop_customers') }}
)

SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name
FROM customers
