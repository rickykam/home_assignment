with uw_info as (

    select 
    * 
    from {{ ref('stg_uw_info') }} 
)


SELECT 

    underwriter_id, 
    name, 
    license_status

FROM uw_info 