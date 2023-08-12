WITH city_transaction_stats AS (
  SELECT city, COUNT(*) AS total_no_of_transactions, MIN([Date]) AS first_date, MAX([Date]) AS last_date,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY MIN([Date])) AS row_num
  FROM credit_card_transactions
  GROUP BY city
)
SELECT cts.city, cts.first_date, cts.last_date, [Date] AS trans_date_500th,
  DATEDIFF(day, cts.first_date, [Date]) AS days_till_500th
FROM city_transaction_stats AS cts
INNER JOIN credit_card_transactions AS cct ON cts.city = cct.city
WHERE cts.row_num = 500
ORDER BY days_till_500th;
