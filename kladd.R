library(dplyr)
library(tidyverse)
library(readr)

df <- read_xlsx("enheter_alle.xlsx")

#filtrert_df <- df %>%
 # filter(Organisasjonsform.kode %in% c("FKF", "FYLK", "IKS", "KF", "KOMM", "SF", "STAT"))

df <- df %>% 
  rename(nkode2 = `Næringskode 2`)

df <- df %>% 
  rename(nkode1 = `Næringskode 1`)

transport <- df %>%
  filter(startsWith(nkode1, "49") | startsWith(nkode1, "84") | startsWith("52"))

#transport_offentlig <- transport %>%
  #filter(Organisasjonsform.kode %in% c("FKF", "FYLK", "IKS", "KF", "KOMM", "SF", "STAT"))

#df_transport <- df %>%
  #filter(startsWith(nkode1, "49"))

