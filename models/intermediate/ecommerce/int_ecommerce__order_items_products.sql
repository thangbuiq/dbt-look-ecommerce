{{ config(materialized="table") }}

with
    order_items_products as (
        select
            -- order_items columns
            order_items.order_item_id,
            order_items.order_id,
            order_items.user_id,
            order_items.product_id,
            order_items.sale_price as item_sale_price,

            -- products columns
            products.cost as product_cost,
            products.retail_price as product_retail_price,
            products.department as product_department,

        from {{ ref("stg_ecommerce__order_items") }} as order_items
        join
            {{ ref("stg_ecommerce__products") }} as products
            on order_items.product_id = products.product_id
    )
select
    order_items_products.*,
    product_retail_price - item_sale_price as item_discount,
    item_sale_price - product_cost as item_profit,

from order_items_products
