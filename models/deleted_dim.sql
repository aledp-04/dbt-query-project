{{ config(materialized='table') }}

SELECT 
    id AS id_corsa,
    creato_il AS deleted_time,
    motivo
FROM {{ source('BigQuery', 'corse_cancellate')}}