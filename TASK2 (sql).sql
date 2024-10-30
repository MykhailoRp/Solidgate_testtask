WITH transaction_data AS (
    SELECT 
        'Transaction' AS transaction_type, 
		t.status AS transaction_status, 
        t.psp_id, 
		t.amount, 
		t.currency_id, 
		t.payment_credentials_id 
    FROM transactions t
	
    UNION ALL
	
    SELECT 
        'Refund' AS transaction_type, 
		r.refund_status AS transaction_status, 
        r.psp_id, 
		r.amount, 
		r.currency_id, 
		r.payment_credentials_id 
    FROM refunds r
	
    UNION ALL
	
    SELECT 
        'Chargeback' AS transaction_type, 
		ch.chb_status AS transaction_status, 
        ch.psp_id, 
		ch.amount, 
		ch.currency_id, 
		ch.payment_credentials_id 
    FROM chargebacks ch
)
SELECT 
    td.transaction_type,
    td.transaction_status,
    p.name AS psp_name,
    td.amount,
    c.iso_code AS currency,
    pc.bin_country AS country
FROM 
    transaction_data td
JOIN 
    psp p ON td.psp_id = p.id
JOIN 
    currencies c ON td.currency_id = c.id
JOIN 
    payment_credentials pc ON td.payment_credentials_id = pc.id;
