-- 3.	Write a query to print the transaction details (all columns from the table) for each card type when it reaches a cumulative of 1000000 total spends (We should have 4 rows in the o/p one for each card type). 
WITH card_type_cumulative AS (
    SELECT *,
           SUM(amount) OVER (PARTITION BY [Card type] ORDER BY [date]) AS cumulative_sum
    FROM credit_card_transactions
), card_type_ranking AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY [Card type] ORDER BY cumulative_sum DESC) AS rn
    FROM card_type_cumulative
    WHERE cumulative_sum >= 1000000
)
SELECT *
FROM card_type_ranking
WHERE rn = 1;

