with 

policy_events as (

    select * , 'AU' as country_code
    FROM {{ source('raw', 'policy_events') }}
),

filter_result as (
    select * from policy_events
   
    {{ build_event_table(var('policy_event_types')) }}
    
)


SELECT 

    cast(policy_id as text) as policy_id,
    cast(upper(event_type) as text) as event_type,
    cast(date(event_date) as date) as event_date,
    cast(upper(channel_override) as text) as channel_override,
    cast(upper(country_code) as text) as country_code

FROM policy_events

