-- A sample 1.sql for task 1
-- Retrieve the top 10 accounts based on the sum of amounts transferred from others.
-- Output
--   (1) id: the account ID
--   (2) value: the transfer amount sum rounded to two decimal places. 
SELECT a2.accountId as id, ROUND(CAST(SUM(t.amount) as numeric), 2) as value 
FROM Account AS a1
JOIN AccountTransferAccount AS t ON a1.accountId = t.fromId
JOIN Account AS a2 ON t.toId = a2.accountId
GROUP BY a2.accountId
ORDER BY SUM(t.amount) DESC 
LIMIT 10;

