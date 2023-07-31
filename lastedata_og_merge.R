####laste inn data 
#fødeland, pensjonist, sysselsatte, inntekt per husholdning, studenter

#pakker:
install.packages("openxlsx")
library(openxlsx)
# Install and load the dplyr package
install.packages("dplyr")
library(dplyr)


####fødeland, sier noe om antall Innvandrere og norskfødte med innvandrerforeldre####
innvandrere <- read.xlsx("fodeland_1.xlsx")
innvandrere
print(innvandrere)

#endre variable navn
library(dplyr)
# Opprett dataframeen med riktige navn
df_innvandring <- data.frame("05182:.Personer,.etter.region,.statistikkvariabel,.år.og.kjønn" = c(NA, NA, NA, "30 Viken", "03 Oslo", "34 Innlandet", "38 Vestfold og Telemark", "42 Agder", "11 Rogaland", "46 Vestland", "15 Møre og Romsdal", "50 Trøndelag - Trööndelage", "18 Nordland - Nordlánnda", "54 Troms og Finnmark - Romsa ja Finnmárku", "21 Svalbard"),
                 X2 = c("Personer", "2023", "Menn", "211216", "163089", "33123", "50685", "37895", "67668", "71970", "26826", "46269", "19611", "23506", "0"),
                 X3 = c(NA, NA, "Kvinner", "199237", "155418", "32876", "49436", "37450", "63013", "68135", "25764", "43295", "18841", "23277", "0"))

# Endre kolonnenavnene
colnames(df_innvandring) <- c("Region", "Personer", "Kjønn")

# Skriv ut den endrede dataframeen
print(df_innvandring)



####alderspensjonist####
pensjonist <- read.xlsx("alderspensjonist.xlsx")
View(pensjonist)
summary(pensjonist)
##endre navn på variable
# Installer og last inn nødvendige pakker
install.packages("dplyr")
library(dplyr)
# Forutsetter at du har dplyr-pakken installert og lastet inn
# Du kan installere pakken med: install.packages("dplyr")
library(dplyr)

# Opprett dataframeen med riktige navn
df_pensjonist <- data.frame("05182:.Personer,.etter.region,.statistikkvariabel,.år.og.kjønn" = c(NA, NA, NA, "30 Viken", "03 Oslo", "34 Innlandet", "38 Vestfold og Telemark", "42 Agder", "11 Rogaland", "46 Vestland", "15 Møre og Romsdal", "50 Trøndelag - Trööndelage", "18 Nordland - Nordlánnda", "54 Troms og Finnmark - Romsa ja Finnmárku", "21 Svalbard"),
                 X2 = c("Personer", "2023", "Menn", "211216", "163089", "33123", "50685", "37895", "67668", "71970", "26826", "46269", "19611", "23506", "0"),
                 X3 = c(NA, NA, "Kvinner", "199237", "155418", "32876", "49436", "37450", "63013", "68135", "25764", "43295", "18841", "23277", "0"))

# Endre kolonnenavnene
colnames(df_pensjonist) <- c("Region", "Personer", "Kjønn")

# Skriv ut den endrede dataframeen
print(df_pensjonist)
View(df_pensjonist)


####studenter####
student <- read.xlsx("studenter.xlsx")


####sysselsatt fylke####
Employed <- read.xlsx("sysselsatt_fylke.xlsx")
Employed <- Employed %>%
  rename(Fylke = X1)

Employed <- Employed %>%
  rename(Fylke = X1,
         Personer_2022 = Personer,
         Personer_2021 = Personer) # Bruk et annet unikt navn for den andre "Personer"-kolonnen.

Employed <- Employed %>%
  mutate(Personer_2022 = Personer,
         Personer_2021 = Personer) %>%
  select(Fylke = X1, Personer_2022, Personer_2021)

# Forutsetter at du har dplyr-pakken installert og lastet inn
# Du kan installere pakken med: install.packages("dplyr")
library(dplyr)

# Fjerne kolonnen "Personer" fra dataframeen "Employed"
Employed <- Employed %>%
  select(-Personer)
View(Employed)

####prøve å merge innvandring og pensjonister per Region/Fylke

# Forutsetter at du har dplyr-pakken installert og lastet inn
# Du kan installere pakken med: install.packages("dplyr")
library(dplyr)

# Slå sammen dataframeene basert på felles kolonne "Region" med many-to-many relasjon og suffiks
merged_df <- inner_join(df_pensjonist, df_innvandring, by = "Region", suffix = c("_pensjonist", "_innvandring"), relationship = "many-to-many")

# Skriv ut den sammenslåtte dataframeen
print(merged_df)
View(merged_df)























