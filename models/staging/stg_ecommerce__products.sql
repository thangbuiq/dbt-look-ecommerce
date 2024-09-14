with source as (
    select * from {{ source('thelook_ecommerce', 'products') }}
)
select * from source
