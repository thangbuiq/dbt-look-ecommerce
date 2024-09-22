with
    source as (select *, from {{ source("thelook_ecommerce", "products") }}),
    renamed as (
        select
            {{ adapter.quote("id") }},
            {{ adapter.quote("cost") }},
            {{ adapter.quote("category") }},
            {{ adapter.quote("name") }},
            {{ adapter.quote("brand") }},
            {{ adapter.quote("retail_price") }},
            {{ adapter.quote("department") }},
            {{ adapter.quote("sku") }},
            {{ adapter.quote("distribution_center_id") }}

        from source
    )
select *,
from renamed
