with source as (
    select * from {{ source('thelook_ecommerce', 'orders') }}
)
select * from source
