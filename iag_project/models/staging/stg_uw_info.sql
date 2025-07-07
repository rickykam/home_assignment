with underwtiters as (

    select * , 'AU' as country_code
    FROM {{ source('raw', 'underwriters') }}
)

select 

    cast(underwriter_id as text) as underwriter_id,
    cast(upper(name) as text) as name,	
    cast(upper(license_status) as text) as license_status,
    cast(upper(country_code) as text) as country_code
    
from underwtiters 


