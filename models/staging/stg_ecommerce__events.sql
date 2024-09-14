with source as (
    select * from {{ source('thelook_ecommerce', 'events') }}
)
select * from source
