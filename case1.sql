-- 1.	Write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends
SELECT city, total_spend,
    ROUND(100 * (total_spend / total_amount), 2) AS percentage_contribution
FROM (
    SELECT city, SUM(amount) AS total_spend
    FROM credit_card_transactions
    GROUP BY city
    ORDER BY total_spend DESC
) AS top_cities
CROSS JOIN (
    SELECT SUM(amount) AS total_amount
    FROM credit_card_transactions
) AS overall_spend;
