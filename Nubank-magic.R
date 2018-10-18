library(readr)
library(dplyr)
library(magrittr)
library(lubridate)
library(rio)
library(stringr)


## Importação do arquivo
# Recebe os lancamentos da fatura Nubank e transforma no formato correto para integração com os sistemas de contabilidade do casal.


#Defina o arquivo

arquivoDoMes <- path.expand("usuario-testNubank.csv")
paste0("Data/",arquivoDoMes)

#Definição da variável
df <- read.csv(file = paste0("Data/",arquivoDoMes)) 

#Criação das colunas de Dia e Mês e a normalização dos nomes dos meses. 

df$Dia <- lubridate::day(x = df$date)
df$Mes <- lubridate::month(x = df$date)
dic <- read_csv(file = "Data/Dicionario.csv")
df <- dplyr::left_join(df, dic, by =  "Mes")

df$ano <- lubridate::year(x = df$date)
rm(dic)


# Salvamento do arquivo consolidado

export(x = df, file = paste0("Outs/", arquivoDoMes, "-processed.csv"))

