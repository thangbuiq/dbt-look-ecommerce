with source as (
    select * from {{ source('thelook_ecommerce', 'distribution_centers') }}
)
select * from source

