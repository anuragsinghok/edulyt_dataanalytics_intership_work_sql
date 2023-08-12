WITH city_transaction_stats AS (
  SELECT city, SUM(amount) AS total_amount, COUNT(*) AS total_no_of_transactions,
    SUM(amount) / COUNT(*) AS transaction_ratio
  FROM credit_card_transactions
  WHERE DATEPART(weekday, [date]) IN (7, 1)
  GROUP BY city
)
SELECT cts.city, cts.total_amount, cts.total_no_of_transactions, cts.transaction_ratio
FROM city_transaction_stats AS cts
WHERE cts.transaction_ratio = (SELECT MAX(transaction_ratio) FROM city_transaction_stats)
ORDER BY cts.city;
