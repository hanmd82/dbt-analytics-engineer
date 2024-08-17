SELECT
    id AS payment_id,
    orderid AS order_id,
    paymentmethod AS payment_method,
    status,
    amount,
    created AS created_date,
    CASE
        WHEN paymentmethod IN ('stripe', 'paypal', 'credit_card', 'gift_card')
            THEN 'credit'
        ELSE 'cash'
    END AS payment_type,
    coalesce(status = 'success', FALSE) AS is_payment_completed
FROM {{ source('stripe', 'payment') }}
