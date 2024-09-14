with source as (
    select * from {{ source('thelook_ecommerce', 'users') }}
)
select * from source
