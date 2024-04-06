-- A sample 1.sql for task 1
-- Retrieve the top 10 accounts based on the sum of amounts transferred from others.
-- Output
--   (1) id: the account ID
--   (2) value: the transfer amount sum rounded to two decimal places. 
-- SELECT a2.accountId as id, ROUND(CAST(SUM(t.amount) as numeric), 2) as value 
-- FROM AccountTransferAccount AS t
-- JOIN Account AS a1 ON a1.accountId = t.fromId
-- JOIN Account AS a2 ON t.toId = a2.accountId
-- GROUP BY a2.accountId
-- ORDER BY SUM(t.amount) DESC 
-- LIMIT 10;

-- select a1.fromId as id, count(*) as value
-- from AccountTransferAccount as a1
-- join AccountTransferAccount as a2 on a1.toId = a2.fromId
-- join AccountTransferAccount as a3 on a2.toId = a3.fromId and a3.toId = a1.fromId
-- group by id
-- order by id;

select res1.id, round(cast(sum(t2.amount / res1.sum_from) as numeric), 2) as value
from (
    select a.accountId as id, sum(t.amount) as sum_from
    from Account as a
    join AccountTransferAccount as t on a.accountId = t.fromId
    group by id
) as res1
join AccountTransferAccount as t2 on res1.id = t2.toId
group by id
order by id;

-- very short!!!

