{{ config(materialized='table') }}


with base as (
    select
        extract_date,
        product_type,
        policy_id,
        start_date,
        end_date,
        event_type,
        status
    from {{ ref('int_pol_info_event') }}
),

time_dim as (

    select distinct year,month from 
    
    {{ ref('dim_time') }}

    where year >= 2021
    
),

product_list AS (
    select distinct product_type
    from base
),

time_product as (

    select
    td.year,
    td.month,
    pl.product_type
    
    from time_dim td
    left outer join product_list pl
    on 1=1

),

new_policy as (
    select
        CAST(strftime('%Y', CAST(start_date AS TEXT)) AS INTEGER) as year,
        CAST(strftime('%m', CAST(start_date AS TEXT)) AS INTEGER) as month,
        product_type,
        count(distinct policy_id) as tot_new_policies
    from base
    where start_date is not null
    group by year, month, product_type
),

lapsed_policy as (
    select
        CAST(strftime('%Y', CAST(end_date AS TEXT)) AS INTEGER) as year,
        CAST(strftime('%m', CAST(end_date AS TEXT)) AS INTEGER) as month,
        product_type,
        count(distinct policy_id) as tot_lapsed_policies
    from base
    where end_date is not null
      and status = 'LAPSED'
    group by year,month, product_type
),

final as (

    select
        tp.year,
        tp.month,
        tp.product_type,
        coalesce(np.tot_new_policies, 0) as tot_new_policies,
        coalesce(lp.tot_lapsed_policies, 0) as tot_lapsed_policies
    from time_product tp
    
    left outer join new_policy np
    on tp.year = np.year
    and tp.month = np.month
    and tp.product_type = np.product_type
    
    left outer join lapsed_policy lp
    on tp.year = lp.year
    and tp.month = lp.month
    and tp.product_type = lp.product_type
)

select * from final order by year, month, product_type