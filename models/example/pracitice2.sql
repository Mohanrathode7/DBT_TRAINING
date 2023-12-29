{{ config(materialized="view") }}


with
    cte as (
        select
            customer_id,
            order_date,
            dense_rank() over (
                partition by customer_id order by customer_id, order_date
            ) drank
        from mohan.practice.orderss
    )
select
    order_date,
    sum(case when drank = 1 then 1 else 0 end) new_user,
    sum(case when drank > 1 then 1 else 0 end) repeated_user
from cte
group by order_date
