# DATA FRA BRØNNØYSUNDREGISTERET

#### Pakker som er nødvendig ####
library(httr)
library(rjstat)
library(jsonlite)
library(tidyverse)
library(readxl)
library(openxlsx)

#### Laste inn brønnøysundregisterdataene ved hjelp av API ####
# Gikk ikke å bare laste ned de enhetene som hadde den næringskoden vi er interessert i, men fikk til å laste ned datasettet
GET('https://data.brreg.no/enhetsregisteret/api/enheter/lastned/regneark', 
    write_disk("~/Library/CloudStorage/OneDrive-UniversitetetiOslo/Semester 4/ISSSV1337 – Political Data Science Hackathon/Digdir/ISSSV1337-group-digdir/data/enheter.xlsx", overwrite = TRUE))

# da vil datasettet lagres på maskinen i en mappe som heter data, usikker på hvordan dette blir på github, men vi prøver ;D
enheter <- read_excel("data/enheter.xlsx")

#### Filtrere ut transport ####
transport_enheter <- subset(enheter, `Næringskode 1` >= 49 & `Næringskode 1` <= 53)

# lagre datasettet som en egen fil
write.xlsx(transport_enheter, "data/transport_enheter.xlsx")

