{{ config(materialized='table') }}

select
    EXTRACT(MONTH FROM dataNotificacao) as Mes,
    estado, 
    count(estado) as numeroOcorrenciasEstado, 
    sum(ocupacaoSuspeitoCli) as totalOcupacaoSuspeitaCli, 
    sum(ocupacaoSuspeitoUti) as totalOcupacaoSuspeitaUti, 
    sum(ocupacaoConfirmadoCli) as totalOcupacaoConfirmadaCovidCli, 
    sum(ocupacaoConfirmadoUti) as totalOcupacaoConfirmadaCovidUti,
    sum(saidaSuspeitaObitos) as totalSaidasSupeitaCovidObitos, 
    sum(saidaSuspeitaAltas) as totalSaidasSuspeitasCovidAltas, 
    sum(saidaConfirmadaObitos) as totalSaidasConfirmadasCovidObitos, 
    sum(saidaConfirmadaAltas) as totalSaidasConfirmadasCovidAltas
from {{ source('covid19_sus', 'rawdata_covid19_sus_2020') }}
group by Mes, estado
order by estado