WITH source AS (
    SELECT *, FROM {{ source('thelook_ecommerce', 'events') }}
),
renamed AS (
    SELECT
        {{ adapter.quote("id") }},
        {{ adapter.quote("user_id") }},
        {{ adapter.quote("sequence_number") }},
        {{ adapter.quote("session_id") }},
        {{ adapter.quote("created_at") }},
        {{ adapter.quote("ip_address") }},
        {{ adapter.quote("city") }},
        {{ adapter.quote("state") }},
        {{ adapter.quote("postal_code") }},
        {{ adapter.quote("browser") }},
        {{ adapter.quote("traffic_source") }},
        {{ adapter.quote("uri") }},
        {{ adapter.quote("event_type") }}

    FROM source
)
SELECT *, FROM renamed
