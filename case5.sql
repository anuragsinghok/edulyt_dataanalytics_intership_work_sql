WITH city_expense_totals AS (
  SELECT city, [exp type], SUM(amount) AS total_amount
  FROM credit_card_transactions
  GROUP BY city, [exp type]
), city_expense_stats AS (
  SELECT city, total_amount, ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_amount DESC) AS highest_rank,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_amount ASC) AS lowest_rank
  FROM city_expense_totals
)
SELECT ces.city, 
  MAX(CASE WHEN ces.highest_rank = 1 THEN ces.[exp type] END) AS highest_expense_type,
  MAX(CASE WHEN ces.lowest_rank = 1 THEN ces.[exp type] END) AS lowest_expense_type
FROM city_expense_stats AS ces
GROUP BY ces.city
ORDER BY ces.city;
