with 

cust_info AS (

    select 
    * 
    from {{ ref('stg_cust_info') }}
)


SELECT 

    customer_id, 
    risk_segment, 
    region, 
    acquisition_channel 
    
FROM 

cust_info



