-- This is bash template substitution example
SELECT store_id,SUM(amount)
FROM customer_txn
WHERE txn_date BETWEEN ${START_DATE} AND ${END_DATE}
