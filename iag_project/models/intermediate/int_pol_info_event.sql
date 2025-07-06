with 

pol_info as (

    select 
    * 
    from {{ ref('stg_pol_info') }} 

),

pol_event as (
      
    select 
    * 
    from {{ ref('stg_pol_event') }}
)



select 
    date() as extract_date,
    pol_info.customer_id,
    pol_info.policy_id,	
    pol_info.underwriter_id,
    pol_info.product_type,	
    pol_info.channel,	
    pol_info.start_date,	
    pol_info.end_date,	
    pol_info.status,	
    pol_event.event_type,
    pol_event.event_date,
    pol_event.channel_override,
    pol_info.country_code,
    julianday(pol_info.end_date) - julianday(pol_info.start_date) as policy_lifetime_days
    

from pol_info 
left outer JOIN
     pol_event

on 
pol_info.policy_id = pol_event.policy_id 
order by pol_info.customer_id asc ,pol_info.policy_id asc
