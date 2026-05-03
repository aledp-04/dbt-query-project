{{ config(materialized='table') }}

SELECT * FROM {{ source('BigQuery', 'locali')}}