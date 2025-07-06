

with customer AS (

    select *,'AU' as country_code
    from {{ source('raw', 'customers') }}
    
/*  For new Market like NZ, we can union the new source table
    unionall
    select *,'NZ' as country_code
    from { source('raw_nz', 'customers') } */

)


SELECT 

    customer_id,	
    upper(risk_segment) as risk_segment,
    upper(region) as region,
    upper(acquisition_channel) as acquisition_channel,
    loyalty_score,
    country_code

FROM customer
