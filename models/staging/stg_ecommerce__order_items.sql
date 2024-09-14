with source as (
    select * from {{ source('thelook_ecommerce', 'order_items') }}
)
select * from source
