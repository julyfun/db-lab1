-- select person_id as id, round(cast(sum(loan_amount) as numeric), 2) as value
-- from (
--     select distinct Lda.loanId as loan_id, Lda.amount as loan_amount, Poa.personId as person_id
--     from
--         PersonOwnAccount as Poa
--         join AccountTransferAccount as Ata on Ata.toId = Poa.accountId
--         join LoanDepositAccount as Lda on Lda.accountId = Ata.fromId
--     ) as PersonLoan
--     group by person_id
-- order by id;
-- limit 20;
-- very short!!!

with recursive Chain as (
    select P.fromId as g, P.toId as ged, 1 as level
    from PersonGuaranteePerson as P
    union all
    select Chain.g, P.toId, Chain.level + 1 -- 仅对上一次递归的结果进行扩展
    -- 主人保持不变，看看
    from
        Chain
        join PersonGuaranteePerson as P on Chain.ged = P.fromId 
    where chain.level <= 3
    
),
Loans as (
    select distinct  Loan.loanId as loanId, Chain.g as g, Loan.loanAmount as loanAmount
    -- (主人, loadId) 必须无重复
    from  
        Chain
        join PersonApplyLoan as Pa on Chain.ged = Pa.personId
        join Loan on Pa.loanId = Loan.loanId
)
select Loans.g as id, round(cast(sum(Loans.loanAmount) as numeric), 2) as value
from Loans
group by Loans.g
order by id;

