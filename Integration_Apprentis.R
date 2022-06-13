setwd("C:/Users/camil/Documents/Fac/M1/M1 S2/Stage")

library(tidyverse)
library(dplyr)
library(questionr)
library(readr)

read_and_sum <- function(file) {
  Empl <- read.csv(file, dec=".")
  if("EXTRIN" %in% colnames(Empl)) {
    Empl <- Empl %>%
      mutate(EXTRI = EXTRIN)
  }
  Empl %>%
    group_by(ANNEE = as.numeric(ANNEE),
             AD, AQ, S,
             FI, ST) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

#Lecture des fichiers
#Pour que ce code fonctionne, rajouter "2" après "Empl" dans le nom du fichier :
#Exemple : Empl75qi.csv devient Empl275.csv

emploi.raw2 <- tibble()
for(f in list.files("data/Csv/",pattern = "Empl2", ignore.case = TRUE)) {
  print(f)
  emploi.raw2 <- bind_rows(emploi.raw2, read_and_sum(paste0("data/Csv/",f)))
}

# Reformatage des variables avec la commande irec() du package questionr


## Recodage de emploi.raw2$ST en emploi.raw2$ST_rec
emploi.raw2$ST <- emploi.raw2$ST %>%
  as.character() %>%
  fct_recode(
    "Non apprentis" = "0",
    "Non apprentis" = "1",
    "Non apprentis" = "2",
    "Non apprentis" = "3",
    "Non apprentis" = "4",
    "Apprentis" = "5",
    "Non apprentis" = "6",
    "Non apprentis" = "7",
    "Non apprentis" = "8"
  ) %>%
  fct_explicit_na("Non apprentis")


## Recodage de emploi.raw7581$S en emploi.raw7174$S_rec
emploi.raw2$S <- emploi.raw2$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )



emploi.raw2$Activite <- ifelse(emploi.raw2$ST == "Apprentis",  "Apprentis", emploi.raw2$FI)

## Recodage de emploi.raw7581$FI
emploi.raw2$Activite <- emploi.raw2$Activite %>%
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


emploi2 <- emploi.raw2 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = AQ,
    Sexe = S,
    Activite = Activite) %>%
  group_by(Annee,Age,AgeQ,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()


#Traitement des données de 1982 à 1989
read_and_sum <- function(file) {
  Empl <- read.csv(file, dec=".")
  if("extri" %in% colnames(Empl)) {
    Empl <- Empl %>%
      mutate(EXTRI = extri)
  }
  Empl %>%
    group_by(ANNEE = as.numeric(ANNEE),
             AG, AQ1, S,
             FI, STATUT) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

# Lecture de tous les fichiers emploi de 1982 à 1989
#Pour que ce code fonctionne, rajouter "3" après "Empl" dans le nom du fichier :
#Exemple : Empl82qi.csv devient Empl382.csv

emploi.raw3 <- tibble()
for(f in list.files("data/Csv/",pattern = "Empl3", ignore.case = TRUE)) {
  print(f)
  emploi.raw3 <- bind_rows(emploi.raw3, read_and_sum(paste0("data/Csv/",f)))
}

# Reformatage des variables avec la commande irec() du package questionr

## Recodage de emploi.raw3$STATUT
emploi.raw3$STATUT <- emploi.raw3$STATUT %>%
  as.character() %>%
  fct_recode(
    "Non apprentis" = "1",
    "Non apprentis" = "2",
    "Non apprentis" = "3",
    "Non apprentis" = "4",
    "Non apprentis" = "11",
    "Non apprentis" = "12",
    "Non apprentis" = "13",
    "Non apprentis" = "21",
    "Apprentis" = "22",
    "Non apprentis" = "23",
    "Non apprentis" = "24",
    "Non apprentis" = "25",
    "Non apprentis" = "26",
    "Non apprentis" = "27",
    "Non apprentis" = "28",
    "Non apprentis" = "29",
    "Non apprentis" = "31",
    "Non apprentis" = "32",
    "Non apprentis" = "33",
    "Non apprentis" = "34",
    "Non apprentis" = "35",
    "Non apprentis" = "36",
    "Non apprentis" = "37"
  ) %>%
  fct_explicit_na("Non Apprentis")


## Recodage de emploi.raw8289$S 
emploi.raw3$S <- emploi.raw3$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )

emploi.raw3$Activite <- ifelse(emploi.raw3$STATUT == "Apprentis",  "Apprentis", emploi.raw3$FI)

## Recodage de emploi.raw7581$FI
emploi.raw3$Activite <- emploi.raw3$Activite %>%
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


emploi3 <- emploi.raw3 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Activite = Activite) %>%
  group_by(Annee,Age,AgeQ,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

#Traitement des données de 1990 à 2002

read_and_sum <- function(file) {
  Empl <- read.csv(file, dec=".")
  if("extri" %in% colnames(Empl)) {
    Empl <- Empl %>%
      mutate(EXTRI = extri)
  }
  Empl %>%
    group_by(ANNEE = as.numeric(ANNEE),
             AG, AGQ, S,
             ACT7, STATUT) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

# Lecture de tous les fichiers emploi de 1990 à 2002
#Pour que ce code fonctionne, rajouter "4" après "Empl" dans le nom du fichier :
#Exemple : Empl90qi.csv devient Empl490.csv

emploi.raw4 <- tibble()
for(f in list.files("data/Csv/",pattern = "Empl4", ignore.case = TRUE)) {
  print(f)
  emploi.raw4 <- bind_rows(emploi.raw4, read_and_sum(paste0("data/Csv/",f)))
}

# Reformatage des variables avec la commande irec() du package questionr


## Recodage de emploi.raw4$STATUT
emploi.raw4$STATUT <- emploi.raw4$STATUT %>%
  as.character() %>%
  fct_recode(
    "Non apprentis" = "11",
    "Non apprentis" = "12",
    "Non apprentis" = "13",
    "Non apprentis" = "21",
    "Apprentis" = "22",
    "Non apprentis" = "23",
    "Non apprentis" = "24",
    "Non apprentis" = "30",
    "Non apprentis" = "41",
    "Non apprentis" = "42"
  ) %>%
  fct_explicit_na("Non apprentis")


## Recodage de emploi.raw7581$S en emploi.raw7174$S_rec
emploi.raw4$S <- emploi.raw4$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )


emploi.raw4$Activite <- ifelse(emploi.raw4$STATUT == "Apprentis",  "Apprentis", emploi.raw4$ACT7)

## Recodage de emploi.raw9002$ACT7
emploi.raw4$Activite <- emploi.raw4$Activite %>%
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

emploi4 <- emploi.raw4 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Activite = Activite) %>%
  group_by(Annee,Age,AgeQ,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

#2003 à 2020
read_and_sum <- function(file) {
  indiv <- read.csv2(file, dec=".")
  if("extri" %in% colnames(indiv)) {
    indiv <- indiv %>%
      mutate(EXTRI = extri)
  }
  indiv %>%
    group_by(ANNEE = as.numeric(ANNEE),
             AGE, AGEQ, SEXE,
             ACTEU6, STATUTR) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

# Lecture de tous les fichiers indiv
emploi.raw5 <- tibble()
for(f in list.files("data/Csv/",pattern = "indiv9", ignore.case = TRUE)) {
  print(f)
  emploi.raw5 <- bind_rows(emploi.raw5, read_and_sum(paste0("data/Csv/",f)))
}

emploi.raw5$SEXE <- emploi.raw5$SEXE %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )



## Recodage de emploi.raw5$STATUTR
emploi.raw5$STATUTR <- emploi.raw5$STATUTR %>%
  as.character() %>%
  fct_recode(
    "Non apprentis" = "1",
    "Non apprentis" = "2",
    "Apprentis" = "3",
    "Non apprentis" = "4",
    "Non apprentis" = "5",
    "Non apprentis" = "9"
  ) %>%
  fct_explicit_na("Non apprentis")

emploi.raw5$Activite <- ifelse(emploi.raw5$STATUTR == "Apprentis",  "Apprentis", emploi.raw5$ACTEU6)


emploi.raw5$Activite <- emploi.raw5$Activite %>%
  as.character() %>%
  fct_recode(
    "Actif occupe" = "1",
    "Chomeur ou inactif" = "3",
    "Chomeur ou inactif" = "4",
    "Etudiant" = "5",
    "Chomeur ou inactif" = "6",
  )


# Reformatage des variables
emploi5 <- emploi.raw5 %>%
  mutate(
    Annee = ANNEE,
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = SEXE,
    Activite = Activite) %>%
  group_by(Annee,Age,AgeQ,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()



#Empilement des tables pour en avoir une seule qui a toutes les informations


emploiAppr <- rbind(emploi2, emploi3, emploi4, emploi5)


save(emploiAppr, file = "emploiappr.RData")













