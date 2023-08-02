#### Load Data/ Factors that can be include at Fylkes/ Region- level. 
# Data at the county level: Factors like birth country, gender, and number of retirees per county


#Packages:
#install.packages("openxlsx")
library(openxlsx)
#install.packages("dplyr")
library(dplyr)


####Lode in factor: immigrant pr Region####
#The file "fodeland_1.xlsx" indicates the number of immigrants and native-born with immigrant parents####
immigrant <- read.xlsx("fodeland_1.xlsx")

###Change variable names
#Create the dataframe with correct names
df_immigrant <- data.frame("05182:.Personer,.etter.region,.statistikkvariabel,.år.og.kjønn" = c(NA, NA, NA, "30 Viken", "03 Oslo", "34 Innlandet", "38 Vestfold og Telemark", "42 Agder", "11 Rogaland", "46 Vestland", "15 Møre og Romsdal", "50 Trøndelag - Trööndelage", "18 Nordland - Nordlánnda", "54 Troms og Finnmark - Romsa ja Finnmárku", "21 Svalbard"),
                 X2 = c("Personer", "2023", "Menn", "211216", "163089", "33123", "50685", "37895", "67668", "71970", "26826", "46269", "19611", "23506", "0"),
                 X3 = c(NA, NA, "Kvinner", "199237", "155418", "32876", "49436", "37450", "63013", "68135", "25764", "43295", "18841", "23277", "0"))

#Change colum names
colnames(df_immigrant) <- c("Region", "Personer", "Kjønn")


####Lode in factor: Retiree / Pensioner ####
retired <- read.xlsx("alderspensjonist.xlsx")

###Change variable names
#Create the dataframe with correct names
df_retired <- data.frame("05182:.Personer,.etter.region,.statistikkvariabel,.år.og.kjønn" = c(NA, NA, NA, "30 Viken", "03 Oslo", "34 Innlandet", "38 Vestfold og Telemark", "42 Agder", "11 Rogaland", "46 Vestland", "15 Møre og Romsdal", "50 Trøndelag - Trööndelage", "18 Nordland - Nordlánnda", "54 Troms og Finnmark - Romsa ja Finnmárku", "21 Svalbard"),
                 X2 = c("Personer", "2023", "Menn", "211216", "163089", "33123", "50685", "37895", "67668", "71970", "26826", "46269", "19611", "23506", "0"),
                 X3 = c(NA, NA, "Kvinner", "199237", "155418", "32876", "49436", "37450", "63013", "68135", "25764", "43295", "18841", "23277", "0"))

##Change colum names
colnames(df_retired) <- c("Region", "Personer", "Kjønn")



####Merge immigration and retirees per Region factors####

##Merge the dataframes based on the common column "Region" using many-to-many relationship and suffixes
merged_df <- inner_join(df_retired, df_immigrant, by = "Region", suffix = c("_pensjonist", "_innvandring"), relationship = "many-to-many")

##Change the variable names in merged_df by assigning new names to the columns
colnames(merged_df) <- c("Region", "Retired_Man", "Retired_Woman", "Immigrant_Man", "Immigrant_Woman")

###Remove rows 1 to 9, which contain empty columns, from merged_df
merged_df <- merged_df %>%
  slice(-c(1:9))

### The final merged dataset
print(merged_df)
View(merged_df)

####The dataset is based on some of the factors that can indicate which groups are more likely to experience digital exclusion based on the Region/Fylkes level. The data are obtained from Statistics Norway (SSB).














