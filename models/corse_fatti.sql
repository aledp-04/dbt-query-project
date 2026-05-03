{{ config(materialized='table') }}

WITH corse_start AS (
    SELECT *
    FROM {{ source('BigQuery', 'corse') }}
),

richieste AS (
    SELECT * FROM {{ source('BigQuery', 'corse_richieste')}}
),

accettate AS (
    SELECT * FROM {{ source('BigQuery', 'corse_accettate')}}
),

iniziate AS (
    SELECT * FROM {{ source('BigQuery', 'corse_iniziate')}}
),

completate AS (
    SELECT * FROM {{ source('BigQuery', 'corse_completate')}}
), 

corse AS (
    SELECT 
        corse_start.id AS id_corsa,
        corse_start.id_rider,
        corse_start.id_cliente,
        corse_start.id_locale,
        richieste.creato_il AS requested_time,
        accettate.creato_il AS accepted_time,
        iniziate.creato_il AS started_time,
        completate.creato_il AS completed_time
    FROM corse_start
    JOIN richieste
    ON corse_start.id = richieste.id_corsa
    JOIN accettate
    ON corse_start.id = accettate.id_corsa
    JOIN iniziate
    ON corse_start.id = iniziate.id_corsa
    JOIN completate
    ON corse_start.id = completate.id_corsa
)

SELECT * FROM corse