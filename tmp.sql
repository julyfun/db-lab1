with res as (
    select * from company
),
res2 as (
    select * from company
)
(select id from res)
union all
(select id from res2);

