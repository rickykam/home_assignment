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

    policy_id,
    upper(event_type) as event_type,
    date(event_date) as event_date,
    upper(channel_override) as channel_override,
    country_code

FROM policy_events

