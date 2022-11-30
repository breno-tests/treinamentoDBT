/* Esse modelo irá juntar todos os estados que tiveram registros em Janeiro */
/* E com os dados de janeiro de cada estado, realizar a média diária de ocupação e as quantidades de saída do hospital e o motivo */
{{ config(materialized='view') }}

with stg_brasil as (select * from {{ ref('stg_ocupacao_brasil_porEstado')}} 
),

outubro2020 as(
    select
        stg_brasil.estado,
        stg_brasil.numeroOcorrenciasEstado,
        stg_brasil.Mes,
        stg_brasil.totalOcupacaoSuspeitaCli / 31 AS mediaOcupacaoDiariaSuspeitaClinica,
        stg_brasil.totalOcupacaoSuspeitaUti / 31 AS mediaOcupacaoDiariaSuspeitaUti,
        stg_brasil.totalOcupacaoConfirmadaCovidCli / 31 AS mediaOcupacaoDiariaConfirmadaCovidClinica,
        stg_brasil.totalOcupacaoConfirmadaCovidUti / 31 AS mediaOcupacaoDiariaConfirmadaCovidUti,
        stg_brasil.totalSaidasSupeitaCovidObitos AS obitosSuspeitaCovid,
        stg_brasil.totalSaidasSuspeitasCovidAltas AS altasSuspeitaCovid,
        stg_brasil.totalSaidasConfirmadasCovidObitos AS obitosConfirmadosCovid,
        stg_brasil.totalSaidasConfirmadasCovidAltas AS altasConfirmadasCovid,
    from stg_brasil
    where Mes = 10
    order by estado ASC
)
select * from outubro2020 order by estado ASC