# DATA FRA BRØNNØYSUNDREGISTERET

#### Pakker som er nødvendig ####
library(httr)
library(rjstat)
library(jsonlite)
library(tidyverse)
library(readxl)
library(openxlsx)
library(dplyr)

#### Laste inn brønnøysundregisterdataene ved hjelp av API ####
# Gikk ikke å bare laste ned de enhetene som hadde den næringskoden vi er interessert i, men fikk til å laste ned datasettet
GET('https://data.brreg.no/enhetsregisteret/api/enheter/lastned/regneark', 
    write_disk("~/Library/CloudStorage/OneDrive-UniversitetetiOslo/Semester 4/ISSSV1337 – Political Data Science Hackathon/Digdir/ISSSV1337-digdir/data/enheter.xlsx", overwrite = TRUE))

# da vil datasettet lagres på maskinen i en mappe som heter data, usikker på hvordan dette blir på github, men vi prøver ;D
enheter <- read_excel("data/enheter.xlsx")

#### Filtrere ut transport ####

# ved å bare filtrere ut på næringskoder mellom 49 og 53 får man ikke med det som er statlig innenfor samferdsel
transport_enheter <- subset(enheter, `Næringskode 1` >= 49 & `Næringskode 1` <= 53)

# filtrere og og utforske hva som skiller men også hva som er likheter mellom de enhetene som er innenfor samferdsel men
# som ikke er innefor samferdsels næringskoden

enheter <- enheter %>% 
  rename(Næringskode = `Næringskode 1`)

enheter$Næringskode <- as.numeric(enheter$Næringskode) # endre næringskode til numeric, lettere å jobbe med

dir_enheter <- enheter %>% 
  filter(Næringskode %in% c(84.130))

tran_dir_enheter <- dir_enheter %>% 
  filter(Organisasjonsform.kode %in% c("AS"))

# Example: Rename columns in tran_dir_enheter to match transport_enheter
colnames(tran_dir_enheter) <- colnames(transport_enheter)

transport_enheter_alle <- rbind(transport_enheter, tran_dir_enheter)

#### Rydde i datasettet transport_enheter_alle ####
# Rydde slik at vi ikke har så mange variabler som vi ikke trenger
transport_enheter_alle <- transport_enheter_alle %>% 
  select(-c(`Næringskode 2`, `Næringskode 2.beskrivelse`, `Næringskode 3`, `Næringskode 3.beskrivelse`, Hjelpeenhetskode, 
            Hjelpeenhetskode.beskrivelse, `Antall ansatte`, Postadresse.adresse, Postadresse.kommune, 
            Postadresse.kommunenummer, Postadresse.land, Postadresse.landkode, Postadresse.poststed, 
            Postadresse.postnummer, Forretningsadresse.adresse, Forretningsadresse.poststed, Forretningsadresse.postnummer,
            Forretningsadresse.kommune, Forretningsadresse.kommunenummer, Forretningsadresse.land, 
            Forretningsadresse.landkode, `Siste innsendte årsregnskap`, `Registreringsdato i Enhetsregisteret`, 
            Stiftelsesdato, FrivilligRegistrertIMvaregisteret, `Registrert i MVA-registeret`, 
            `Registrert i Foretaksregisteret`, `Registrert i Frivillighetsregisteret`, `Registrert i Stiftelsesregisteret`,
            Konkurs, `Under avvikling`, `Under tvangsavvikling eller tvangsoppløsning`, Målform))

# endre på variabelnavnene slik at de blir lettere å jobbe med
transport_enheter_alle <- transport_enheter_alle %>% 
  rename(organisasjonsnummer = Organisasjonsnummer,
         navn = Navn, 
         organisasjonsform_kode = Organisasjonsform.kode,
         organisasjonsform_beskrivelse = Organisasjonsform.beskrivelse,
         naeringskode = `Næringskode 1`, 
         naeringskode_beskrivelse = `Næringskode 1.beskrivelse`, 
         hjemmeside = Hjemmeside, 
         institusjonell_sektorkode = `Institusjonell sektorkode`, 
         institusjonell_sektorkode_beskrivelse = `Institusjonell sektorkode.beskrivelse`,
         overordnet_enhet = `Overordnet enhet i offentlig sektor`)

tran_enheter_narm <- transport_enheter_alle

tran_enheter_narm$overordnet_enhet <- as.numeric(tran_enheter_narm$overordnet_enhet)
tran_enheter_narm$institusjonell_sektorkode <- as.numeric(tran_enheter_narm$institusjonell_sektorkode)

# Assuming 'tran_enheter_narm' is your dataset
# Replace NA values with 0 in numeric columns
numeric_cols <- sapply(tran_enheter_narm, is.numeric)
tran_enheter_narm[, numeric_cols][is.na(tran_enheter_narm[, numeric_cols])] <- 0

# Replace NA values with "NA" in character columns
character_cols <- sapply(tran_enheter_narm, is.character)
tran_enheter_narm[, character_cols][is.na(tran_enheter_narm[, character_cols])] <- "NA"


#### lagre datasettet som en egen fil ####
write.xlsx(transport_enheter_alle, "data/transport_enheter_alle.xlsx")

write.xlsx(tran_enheter_narm, "data/tran_enheter_narm.xlsx")

