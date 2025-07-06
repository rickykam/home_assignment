with policies AS (

    select * , 'AU' as country_code
    FROM {{ source('raw', 'policies') }}
)


SELECT 

    policy_id,	
    customer_id,
    underwriter_id,
    upper(product_type) as product_type,
    upper(channel) as channel,
    date(start_date) as start_date,
    date(end_date) as end_date,
    upper(status) as status,
    upper(source_system) as source_system,
    country_code

FROM policies

