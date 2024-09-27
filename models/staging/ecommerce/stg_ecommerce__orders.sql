{{ config(materialized="table") }}

with
    source as (select * from {{ source("thelook_ecommerce", "orders") }}),
    renamed as (
        select
            {{ adapter.quote("order_id") }},
            {{ adapter.quote("user_id") }},
            {{ adapter.quote("status") }},
            {{ adapter.quote("gender") }},
            {{ adapter.quote("created_at") }},
            {{ adapter.quote("returned_at") }},
            {{ adapter.quote("shipped_at") }},
            {{ adapter.quote("delivered_at") }},
            {{ adapter.quote("num_of_item") }}

        from source
    )
select *
from renamed
