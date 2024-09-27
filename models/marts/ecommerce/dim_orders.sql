{{ config(materialized="table") }}

with order_items_products as (
    select * from {{ ref('int_ecommerce__order_items_products') }}
)
select * from order_items_products