setwd("C:/Users/camil/Documents/Fac/M1/M1 S2/Stage")

library(tidyverse)
library(dplyr)
library(questionr)
library(readr)

###Lecture des fichiers ###


indiv71 <- read.csv(file = "data/Csv/Empl171qi.csv")
indiv72 <- read.csv(file = "data/Csv/Empl172qi.csv")
indiv73 <- read.csv(file = "data/Csv/Empl173qi.csv")
indiv74 <- read.csv(file = "data/Csv/Empl174qi.csv")
indiv75 <- read.csv(file = "data/Csv/Empl275qi.csv")
indiv76 <- read.csv(file = "data/Csv/Empl276qi.csv")
indiv77 <- read.csv(file = "data/Csv/Empl277qi.csv")
indiv78 <- read.csv(file = "data/Csv/Empl278qi.csv")
indiv79 <- read.csv(file = "data/Csv/Empl279qi.csv")
indiv80 <- read.csv(file = "data/Csv/Empl280qi.csv")
indiv81 <- read.csv(file = "data/Csv/Empl281qi.csv")
indiv82 <- read.csv(file = "data/Csv/Empl382qi.csv")
indiv83 <- read.csv(file = "data/Csv/Empl383qi.csv")
indiv84 <- read.csv(file = "data/Csv/Empl384qi.csv")
indiv85 <- read.csv(file = "data/Csv/Empl385qi.csv")
indiv86 <- read.csv(file = "data/Csv/Empl386qi.csv")
indiv87 <- read.csv(file = "data/Csv/Empl387qi.csv")
indiv88 <- read.csv(file = "data/Csv/Empl388qi.csv")
indiv89 <- read.csv(file = "data/Csv/Empl389qi.csv")
indiv90 <- read.csv(file = "data/Csv/Empl490qi.csv")
indiv91 <- read.csv(file = "data/Csv/Empl491qi.csv")
indiv91 <- read.csv(file = "data/Csv/Empl491qi.csv")
indiv92 <- read.csv(file = "data/Csv/Empl492qi.csv")
indiv93 <- read.csv(file = "data/Csv/Empl493qi.csv")
indiv94 <- read.csv(file = "data/Csv/Empl494qi.csv")
indiv95 <- read.csv(file = "data/Csv/Empl495qi.csv")
indiv96 <- read.csv(file = "data/Csv/Empl496qi.csv")
indiv97 <- read.csv(file = "data/Csv/Empl497qi.csv")
indiv98 <- read.csv(file = "data/Csv/Empl498qi.csv")
indiv99 <- read.csv(file = "data/Csv/Empl499qi.csv")
indiv00 <- read.csv(file = "data/Csv/Empl400qi.csv")
indiv01 <- read.csv(file = "data/Csv/Empl401qi.csv")
indiv02 <- read.csv(file = "data/Csv/Empl402qi.csv")
indiv03 <- read.csv2(file = "data/Csv/indiv9031.csv")
indiv04 <- read.csv2(file = "data/Csv/indiv9041.csv")
indiv05 <- read.csv2(file = "data/Csv/indiv9051.csv")
indiv06 <- read.csv2(file = "data/Csv/indiv9061.csv")
indiv07 <- read.csv2(file = "data/Csv/indiv9071.csv")
indiv08 <- read.csv2(file = "data/Csv/indiv9081.csv")
indiv09 <- read.csv2(file = "data/Csv/indiv9091.csv")
indiv10 <- read.csv2(file = "data/Csv/indiv9101.csv")
indiv11 <- read.csv2(file = "data/Csv/INDIV9111.csv")
indiv12 <- read.csv2(file = "data/Csv/INDIV9121.csv")
indiv13 <- read.csv2(file = "data/Csv/INDIV9131.csv")
indiv14 <- read.csv2(file = "data/Csv/INDIV9141.csv")
indiv15 <- read.csv2(file = "data/Csv/INDIV9151.csv")
indiv16 <- read.csv2(file = "data/Csv/INDIV9161.csv")
indiv17 <- read.csv2(file = "data/Csv/INDIV9171.csv")
indiv18 <- read.csv2(file = "data/Csv/INDIV9181.csv")
indiv19 <- read.csv2(file = "data/Csv/INDIV9191.csv")
indiv20 <- read.csv2(file = "data/Csv/INDIV9201.csv")

### Recodage des variables importantes (noms)

indiv71 <- indiv71 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = ADD,
    Sexe = S,
    Diplome = DIP,
    Activite = CSE)

indiv71 <- indiv71 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv72 <- indiv72 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = ADD,
    Sexe = S,
    Diplome = DIP,
    Activite = CSE)

indiv72 <- indiv72 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv73 <- indiv73 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = ADD,
    Sexe = S,
    Diplome = DIP,
    Activite = CSE)

indiv73 <- indiv73 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv74 <- indiv74 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = ADD,
    Sexe = S,
    Diplome = DIP,
    Activite = CSE)

indiv74 <- indiv74 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv7174 <- rbind(indiv71, indiv72, indiv73, indiv74)

indiv7174$Sexe <- indiv7174$Sexe %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )



## Recodage de emploi.raw7174$CSE

indiv7174$Activite <- indiv7174$Activite %>%
  as.character() %>%
  fct_recode(
    "Actif occupe" = "0",
    "Actif occupe" = "10",
    "Actif occupe" = "21",
    "Actif occupe" = "22",
    "Actif occupe" = "23",
    "Actif occupe" = "26",
    "Actif occupe" = "27",
    "Actif occupe" = "30",
    "Actif occupe" = "32",
    "Actif occupe" = "33",
    "Actif occupe" = "34",
    "Actif occupe" = "41",
    "Actif occupe" = "42",
    "Actif occupe" = "43",
    "Actif occupe" = "44",
    "Actif occupe" = "51",
    "Actif occupe" = "53",
    "Actif occupe" = "60",
    "Actif occupe" = "61",
    "Actif occupe" = "63",
    "Actif occupe" = "65",
    "Actif occupe" = "66",
    "Actif occupe" = "67",
    "Actif occupe" = "68",
    "Actif occupe" = "70",
    "Actif occupe" = "71",
    "Actif occupe" = "72",
    "Actif occupe" = "80",
    "Actif occupe" = "81",
    "Actif occupe" = "82",
    "Etudiant" = "91",
    "Actif occupe" = "92",
    "Chomeur ou inactif" = "93",
    "Chomeur ou inactif" = "94",
    "Chomeur ou inactif" = "95",
    "Chomeur ou inactif" = "96",
    "Chomeur ou inactif" = "97",
    "Chomeur ou inactif" = "98",
    "Chomeur ou inactif" = "99"
  )


## Recodage de emploi.raw7174$DIP
indiv7174$Diplome <- indiv7174$Diplome %>%
  as.character() %>%
  fct_recode(
    "Aucun" = "00",
    "Aucun" = "10",
    "CAP-BEP" = "21",
    "CAP-BEP" = "22",
    "CAP-BEP" = "23",
    "DNB" = "30",
    "CAP-BEP" = "31",
    "CAP-BEP" = "32",
    "CAP-BEP" = "33",
    "Bac" = "40",
    "Bac" = "41",
    "Bac" = "42",
    "Bac" = "43",
    "CAP-BEP" = "44",
    "CAP-BEP" = "45",
    "Bac+2" = "46",
    "Bac+2" = "50",
    "Bac+3" = "51",
    "Bac+2" = "52",
    "Bac+2" = "53",
    "Bac+2" = "54",
    "Bac+5" = "60",
    "Bac+5" = "61",
    NULL = "90"
  )


### 75 à 81

indiv75 <- indiv75 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = AQ,
    Sexe = S,
    Diplome = DIP,
    Activite = FI,
    EXTRI = EXTRIN) 

indiv75 <- indiv75 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv76 <- indiv76 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = AQ,
    Sexe = S,
    Diplome = DIP,
    Activite = FI,
    EXTRI = EXTRIN) 

indiv76 <- indiv76 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv77 <- indiv77 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = AQ,
    Sexe = S,
    Diplome = DIP,
    Activite = FI,
    EXTRI = EXTRIN) 

indiv77 <- indiv77 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv78 <- indiv78 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = AQ,
    Sexe = S,
    Diplome = DIP,
    Activite = FI,
    EXTRI = EXTRIN) 

indiv78 <- indiv78 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv79 <- indiv79 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = AQ,
    Sexe = S,
    Diplome = DIP,
    Activite = FI,
    EXTRI = EXTRIN) 

indiv79 <- indiv79 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv80 <- indiv80 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = AQ,
    Sexe = S,
    Diplome = DIP,
    Activite = FI,
    EXTRI = EXTRIN) 

indiv80 <- indiv80 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv81 <- indiv81 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = AQ,
    Sexe = S,
    Diplome = DIP,
    Activite = FI,
    EXTRI = EXTRIN) 

indiv81 <- indiv81 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv7581 <- rbind(indiv75, indiv76, indiv77, indiv78, indiv79, indiv80, indiv81)

indiv7581$Diplome <- indiv7581$Diplome %>%
  as.character() %>%
  fct_recode(
    "Aucun" = "0",
    "Aucun" = "00",
    "Aucun" = "10",
    "CAP-BEP" = "21",
    "CAP-BEP" = "22",
    "CAP-BEP" = "23",
    "DNB" = "30",
    "CAP-BEP" = "31",
    "CAP-BEP" = "32",
    "CAP-BEP" = "33",
    "Bac" = "40",
    "Bac" = "41",
    "Bac" = "42",
    "Bac" = "43",
    "CAP-BEP" = "44",
    "CAP-BEP" = "45",
    "Bac+2" = "46",
    "Bac+2" = "50",
    "Bac+3" = "51",
    "Bac+2" = "52",
    "Bac+2" = "53",
    "Bac+2" = "54",
    "Bac+5" = "60",
    "Bac+5" = "61",
    NULL = "90"
  )

## Recodage de emploi.raw7581$S en emploi.raw7174$S_rec
indiv7581$Sexe <- indiv7581$Sexe %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )

## Recodage de emploi.raw7581$FI
indiv7581$Activite <- indiv7581$Activite %>%
  as.character() %>%
  fct_recode(
    "Actif occupe" = "1",
    "Chomeur ou inactif" = "2",
    "Chomeur ou inactif" = "3",
    "Etudiant" = "4",
    "Actif occupe" = "5",
    "Chomeur ou inactif" = "6",
    "Chomeur ou inactif" = "7"
  )

### 82 à 89 ###
indiv82 <- indiv82 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI)

indiv82 <- indiv82 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv83 <- indiv83 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI)

indiv83 <- indiv83 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv84 <- indiv84 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI)

indiv84 <- indiv84 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv85 <- indiv85 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI)

indiv85 <- indiv85 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv86 <- indiv86 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI)

indiv86 <- indiv86 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv87 <- indiv87 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI)

indiv87 <- indiv87 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv88 <- indiv88 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI)

indiv88 <- indiv88 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv89 <- indiv89 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI)

indiv89 <- indiv89 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv8289 <- rbind(indiv82, indiv83, indiv84, indiv85, indiv86, indiv87, indiv88, indiv89)

indiv8289$Sexe <- indiv8289$Sexe %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )

## Recodage de emploi.raw7581$FI
indiv8289$Activite <- indiv8289$Activite %>%
  as.character() %>%
  fct_recode(
    "Actif occupe" = "1",
    "Chomeur ou inactif" = "2",
    "Chomeur ou inactif" = "3",
    "Etudiant" = "4",
    "Actif occupe" = "5",
    "Chomeur ou inactif" = "6",
    "Chomeur ou inactif" = "7",
    "Chomeur ou inactif" = "8"
  )


## Recodage de emploi.raw8283$DIPL
indiv8289$Diplome <- indiv8289$Diplome %>%
  as.character() %>%
  fct_recode(
    "Bac+5" = "10",
    "Bac+5" = "11",
    "Bac+3" = "30",
    "Bac+2" = "31",
    "Bac+2" = "32",
    "Bac+2" = "33",
    "Bac" = "40",
    "Bac" = "41",
    "Bac" = "42",
    "CAP-BEP" = "43",
    "CAP-BEP" = "50",
    "CAP-BEP" = "51",
    "DNB" = "60",
    "Aucun" = "70",
    "Aucun" = "71"
  )

### de 90 à 2002 ###

indiv90 <- indiv90 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv90 <- indiv90 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv91 <- indiv91 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv91 <- indiv91 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv92 <- indiv92 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv92 <- indiv92 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)



indiv93 <- indiv93 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv93 <- indiv93 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)



indiv94 <- indiv94 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv94 <- indiv94 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)



indiv95 <- indiv95 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv95 <- indiv95 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv96 <- indiv96 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv96 <- indiv96 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv97 <- indiv97 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv97 <- indiv97 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv98 <- indiv98 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv98 <- indiv98 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv99 <- indiv99 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv99 <- indiv99 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv00 <- indiv00 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv00 <- indiv00 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv01 <- indiv01 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv01 <- indiv01 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv02 <- indiv02 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

indiv02 <- indiv02 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv9002 <- rbind(indiv90, indiv91, indiv92, indiv93, indiv94, indiv95, indiv96, indiv97, indiv98, indiv99, indiv00, indiv01, indiv02)

indiv9002$Sexe <- indiv9002$Sexe %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )


## Recodage de emploi.raw9002$ACT7
indiv9002$Activite <- indiv9002$Activite %>%
  as.character() %>%
  fct_recode(
    "Actif occupe" = "1",
    "Actif occupe" = "2",
    "Chomeur ou inactif" = "3",
    "Chomeur ou inactif" = "4",
    "Etudiant" = "5",
    "Chomeur ou inactif" = "6",
    "Chomeur ou inactif" = "7"
  )

## Recodage de emploi.raw9002$DIPL
indiv9002$Diplome <- indiv9002$Diplome %>%
  as.character() %>%
  fct_recode(
    "Bac+5" = "10",
    "Bac+5" = "11",
    "Bac+3" = "30",
    "Bac+2" = "31",
    "Bac+2" = "32",
    "Bac+2" = "33",
    "Bac" = "40",
    "Bac" = "41",
    "Bac" = "42",
    "CAP-BEP" = "43",
    "CAP-BEP" = "50",
    "CAP-BEP" = "51",
    "DNB" = "60",
    "Aucun" = "70",
    "Aucun" = "71"
  )

### DE 2003 à 2020 ###

indiv03 <- indiv03 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
  Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv03 <- indiv03 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv04 <- indiv04 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv04 <- indiv04 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv05 <- indiv05 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv05 <- indiv05 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv06 <- indiv06 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv06 <- indiv06 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv07 <- indiv07 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv07 <- indiv07 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv08 <- indiv08 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv08 <- indiv08 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv09 <- indiv09 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv09 <- indiv09 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv10 <- indiv10 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv10 <- indiv10 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv11 <- indiv11 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv11 <- indiv11 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv12 <- indiv12 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(EXTRI))

indiv12 <- indiv12 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv13 <- indiv13 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(extri))

indiv13 <- indiv13 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv14 <- indiv14 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(extri))

indiv14 <- indiv14 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv15 <- indiv15 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(extri))

indiv15 <- indiv15 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv16 <- indiv16 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(extri))

indiv16 <- indiv16 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv17 <- indiv17 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(extri))

indiv17 <- indiv17 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv18 <- indiv18 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(extri))

indiv18 <- indiv18 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv19 <- indiv19 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(extri))

indiv19 <- indiv19 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)


indiv20 <- indiv20 %>%
  mutate(
    Annee = as.numeric(ANNEE),
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Diplome = DIP,
    Activite = ACTEU6,
    EXTRI = as.numeric(extri))

indiv20 <- indiv20 %>%
  select(
    Annee,
    Age,
    AgeQ,
    Sexe,
    Diplome,
    Activite,
    EXTRI)

indiv0320 <- rbind(indiv03, indiv04, indiv05, indiv06, indiv07, indiv08, indiv09, indiv10, indiv11, indiv12, indiv13, indiv14, indiv15, indiv16, indiv17, indiv18, indiv19, indiv20)

indiv0320$Sexe <- indiv0320$Sexe %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )


## Recodage de emploi.raw9002$ACT7
indiv0320$Activite <- indiv0320$Activite %>%
  as.character() %>%
  fct_recode(
    "Actif occupe" = "1",
    "Chomeur ou inactif" = "3",
    "Chomeur ou inactif" = "4",
    "Etudiant" = "5",
    "Chomeur ou inactif" = "6",
  )

## Recodage de emploi.raw9002$DIPL
indiv0320$Diplome <- indiv0320$Diplome %>%
  as.character() %>%
  fct_recode(
    "Bac+5" = "10",
    "Bac+5" = "12",
    "Bac+5" = "22",
    "Bac+3" = "21",
    "Bac+2" = "30",
    "Bac+2" = "31",
    "Bac+2" = "32",
    "Bac+2" = "33",
    "Bac" = "41",
    "Bac" = "42",
    "CAP-BEP" = "43",
    "CAP-BEP" = "44",
    "CAP-BEP" = "50",
    "DNB" = "60",
    "Aucun" = "70",
    "Aucun" = "71"
  )

save(indiv7174, file = "indiv7174.RData")
save(indiv7581, file = "indiv7581.RData")
save(indiv8289, file = "indiv8289.RData")
save(indiv9002, file = "indiv9002.RData")
save(indiv0320, file = "indiv0320.RData")

base_empl <- rbind(indiv7174, indiv7581, indiv8289, indiv9002, indiv0320)

#Suppression des individus sans pondération
base_empl <- base_empl[-c(658637, 792215, 792216, 792217, 792218, 792219, 2168279, 2168280, 4923956, 4923957, 4923958, 4976606, 5310552, 5311482, 5317890, 5359669, 5405808, 5568711, 5568712, 5684404, 5684405, 
                          5696588, 5696589, 5716392, 5716393, 5724248, 5724249, 5728857, 5728858),]


save(base_empl, file = "Base_empl.RData")
