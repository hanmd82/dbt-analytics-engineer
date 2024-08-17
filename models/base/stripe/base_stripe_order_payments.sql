SELECT
    id AS payment_id,
    orderid AS order_id,
    paymentmethod AS payment_method,
    CASE
        WHEN paymentmethod IN ('stripe', 'paypal', 'credit_card', 'gift_card')
        THEN 'credit'
        ELSE 'cash'
    END AS payment_type,
    status,
    amount,
    CASE
        WHEN status = 'success'
        THEN TRUE
        ELSE FALSE
    END AS is_payment_completed,
    created AS created_date
from {{ source('stripe', 'payment') }}
