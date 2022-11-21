{{ config(materialized='table') }}

select
    int64_field_0 as customer_id,
    dataNotificacao,
    cnes
from {{ source('rawdata_covid', 'rawdata_covid19_sus_2020') }}
