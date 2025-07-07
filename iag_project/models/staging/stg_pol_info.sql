with policies AS (

    select * , 'AU' as country_code
    FROM {{ source('raw', 'policies') }}
)


SELECT 

    cast(policy_id as text) as policy_id,	
    cast(customer_id as text) as customer_id,
    cast(underwriter_id as text) as underwriter_id,
    cast(upper(product_type) as text) as product_type,
    cast(upper(channel) as text) as channel,
    cast(date(start_date) as date) as start_date,
    cast(date(end_date) as date) as end_date,
    cast(upper(status) as text) as status,
    cast(upper(source_system) as text) as source_system,
    cast(upper(country_code) as text) as country_code

FROM policies

