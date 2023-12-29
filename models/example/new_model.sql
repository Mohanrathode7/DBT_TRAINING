{{ config(materialized="table") }}


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
    order_date
from cte
group by order_date
