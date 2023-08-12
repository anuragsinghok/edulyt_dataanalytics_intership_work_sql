WITH expense_totals AS (
  SELECT [exp type], SUM(amount) AS total_amount_spent, SUM(CASE WHEN Gender = 'F' THEN amount ELSE 0 END) AS total_amount_female_spent
  FROM credit_card_transactions
  GROUP BY [exp type]
)
SELECT et.[exp type], et.total_amount_female_spent, et.total_amount_spent,
  ROUND(100 * et.total_amount_female_spent / et.total_amount_spent, 2) AS percentage_contribution
FROM expense_totals AS et
ORDER BY percentage_contribution;
