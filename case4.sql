WITH silver_amt_citywise AS (
    SELECT city, SUM(amount) AS silver_amount
    FROM credit_card_transactions
    WHERE [Card type] = 'Silver'
    GROUP BY city
),
total_amt_citywise AS (
    SELECT city, SUM(amount) AS total_amount
    FROM credit_card_transactions
    GROUP BY city
),
contribution AS (
    SELECT s.city, s.silver_amount, t.total_amount, ROUND(100 * s.silver_amount / t.total_amount, 2) AS percentage_contribution
    FROM silver_amt_citywise AS s
    INNER JOIN total_amt_citywise AS t ON s.city = t.city
)
SELECT TOP 1 *
FROM contribution
ORDER BY percentage_contribution ASC;
