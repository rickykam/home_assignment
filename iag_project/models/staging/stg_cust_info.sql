

with customer AS (

    select *,'AU' as country_code
    from {{ source('raw', 'customers') }}
    
/*  For new Market like NZ, we can union the new source table
    unionall
    select *,'NZ' as country_code
    from { source('raw_nz', 'customers') } */

)


SELECT 

    cast(customer_id as text) as customer_id,	
    cast(upper(risk_segment) as text) as risk_segment,
    cast(upper(region) as text) as region,
    cast(upper(acquisition_channel) as test) as acquisition_channel,
    cast(loyalty_score as integer) as loyalty_score,
    cast(upper(country_code) as text) as country_code

FROM customer
