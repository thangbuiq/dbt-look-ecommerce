with source as (
    select * from {{ source('thelook_ecommerce', 'inventory_items') }}
)
select * from source
