with 
policy_info as (

    select 
    *
    from {{ ref('stg_pol_info') }}

)   

    
select 

    policy_id
    --,other attribute

from policy_info 

