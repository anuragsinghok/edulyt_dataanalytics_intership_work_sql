SELECT [Card type], month_name, year_name, total_spend
FROM (
    SELECT [Card type], 
           DATEPART(year, [date]) AS year_name, 
           DATENAME(month, [date]) AS month_name,
           SUM(amount) AS total_spend,
           DENSE_RANK() OVER (PARTITION BY [Card type] ORDER BY SUM(amount) DESC) AS rank
    FROM credit_card_transactions
    GROUP BY [Card type], DATEPART(year, [date]), DATENAME(month, [date])
) AS card_type_data
WHERE rank = 1;
