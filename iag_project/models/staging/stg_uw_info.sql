with underwtiters as (

    select * , 'AU' as country_code
    FROM {{ source('raw', 'underwriters') }}
)

select 

    underwriter_id,
    upper(name) as name,	
    upper(license_status) as license_status,
    country_code
    
from underwtiters 


