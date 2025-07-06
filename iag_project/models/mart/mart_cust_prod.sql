{{ config(materialized='table') }}


with base as (

    select 
        policy_id,
        customer_id,
        product_type,
        start_date,
        end_date,
        status
    from {{ ref('stg_pol_info') }}
),

cust as (

    select distinct customer_id 
    from  {{ ref('stg_cust_info') }}

),

product as (
    select distinct product_type
    from {{ ref('stg_pol_info') }}
), 

cust_prod as (

    select 
        c.customer_id,
        p.product_type
    from cust c
    left outer join product p
    on 1=1 

),

cal_total_act_policy as (

    select 
        b.customer_id,
        b.product_type,
        count(distinct b.policy_id) as tot_act_policy
    
    from base b 
  
    where b.status = 'ACTIVE'
    group by b.customer_id, b.product_type

),

final as (

    select 
        cp.customer_id,
        cp.product_type,
        coalesce(ca.tot_act_policy, 0) as tot_act_policy
    from cust_prod cp
    left outer join cal_total_act_policy ca
    on cp.customer_id = ca.customer_id
    and cp.product_type = ca.product_type

)

select * from final order BY customer_id, product_type
