#Traitement des données de 1968 à 2002
#Chaque fichier de données a été exporté en CSV. La vraiable ANNEE a été ajoutée (via SAS) aux fichiers
#de données qui ne l'incluaient pas initialement 

#J'ai choisi de commencer le traitement de données à partir de 1971 (et non 1968) car les fichiers
#de données avant 1971 ne comprennent pas la variable DIPL (ou de variable équivalente).

#Il faut ici procéder au traitement de données par "séries" car les modalités et les noms de variables
#changent d'une période à l'autre, il faut donc traiter les séries par groupes puis harmoniser les données

setwd("C:/Users/camil/Documents/Fac/M1/M1 S2/Stage")

library(tidyverse)
library(dplyr)
library(questionr)
library(readr)
library(haven)


#Traitement des données de 1971 à 1974

read_and_sum <- function(file) {
  Empl <- read.csv(file, dec=".")
  if("extri" %in% colnames(Empl)) {
    Empl <- Empl %>%
      mutate(EXTRI = extri)
  }
  Empl %>%
    group_by(ANNEE = as.numeric(ANNEE),
             AD, ADD, S,
             CSE,
             DIP = as.numeric(DIP)) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

# Lecture de tous les fichiers emploi de 1971 à 1974
#Pour que ce code fonctionne, rajouter "1" après "Empl" dans le nom du fichier :
#Exemple : Empl74qi.csv devient Empl174.csv

emploi.raw7174 <- tibble()
for(f in list.files("data/Csv/",pattern = "Empl1", ignore.case = TRUE)) {
  print(f)
  emploi.raw7174 <- bind_rows(emploi.raw7174, read_and_sum(paste0("data/Csv/",f)))
}


# Reformatage des variables avec la commande irec() du package questionr


## Recodage de emploi.raw7174$S en emploi.raw7174$S_rec
emploi.raw7174$S <- emploi.raw7174$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )



## Recodage de emploi.raw7174$CSE

emploi.raw7174$CSE <- emploi.raw7174$CSE %>%
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
emploi.raw7174$DIP <- emploi.raw7174$DIP %>%
  as.character() %>%
  fct_recode(
    "Aucun" = "0",
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



emploi7174 <- emploi.raw7174 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = ADD,
    Sexe = S,
    Diplome = DIP,
    Activite = CSE) %>%
  group_by(Annee,Age,AgeQ,Diplome,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()


save(emploi.raw7174,emploi7174,file="emploi7174.RData")


#On procède maintenant à la série 1975 - 1981
#Note : Dans cette série, EXTRI devient EXTRIN :))

read_and_sum <- function(file) {
  Empl <- read.csv(file, dec=".")
  if("EXTRIN" %in% colnames(Empl)) {
    Empl <- Empl %>%
      mutate(EXTRI = EXTRIN)
  }
  Empl %>%
    group_by(ANNEE = as.numeric(ANNEE),
             AD, AQ, S,
             FI,
             DIP = as.numeric(DIP)) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

#Lecture des fichiers
#Pour que ce code fonctionne, rajouter "2" après "Empl" dans le nom du fichier :
#Exemple : Empl75qi.csv devient Empl275.csv

emploi.raw7581 <- tibble()
for(f in list.files("data/Csv/",pattern = "Empl2", ignore.case = TRUE)) {
  print(f)
  emploi.raw7581 <- bind_rows(emploi.raw7581, read_and_sum(paste0("data/Csv/",f)))
}

# Reformatage des variables avec la commande irec() du package questionr

## Recodage de emploi.raw7174$DIP
emploi.raw7581$DIP <- emploi.raw7581$DIP %>%
  as.character() %>%
  fct_recode(
    "Aucun" = "0",
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
emploi.raw7581$S <- emploi.raw7581$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )

## Recodage de emploi.raw7581$FI
emploi.raw7581$FI <- emploi.raw7581$FI %>%
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

emploi7581 <- emploi.raw7581 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = AQ,
    Sexe = S,
    Diplome = DIP,
    
    Activite = FI) %>%
  group_by(Annee,Age,AgeQ,Diplome,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

save(emploi.raw7581,emploi7581,file="emploi7581.RData")

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
             FI,
             DIPL = as.numeric(DIPL)) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

# Lecture de tous les fichiers emploi de 1982 à 1989
#Pour que ce code fonctionne, rajouter "3" après "Empl" dans le nom du fichier :
#Exemple : Empl82qi.csv devient Empl382.csv

emploi.raw8289 <- tibble()
for(f in list.files("data/Csv/",pattern = "Empl3", ignore.case = TRUE)) {
  print(f)
  emploi.raw8289 <- bind_rows(emploi.raw8289, read_and_sum(paste0("data/Csv/",f)))
}

# Reformatage des variables avec la commande irec() du package questionr

## Recodage de emploi.raw8289$S 
emploi.raw8289$S <- emploi.raw8289$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )

## Recodage de emploi.raw7581$FI
emploi.raw8289$FI <- emploi.raw8289$FI %>%
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
emploi.raw8289$DIPL <- emploi.raw8289$DIPL %>%
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

emploi8289 <- emploi.raw8289 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI) %>%
  group_by(Annee,Age,AgeQ,Diplome,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

save(emploi.raw8289,emploi8289,file="emploi8289.RData")


#Traitement des données de 1982 à 1989

read_and_sum <- function(file) {
  Empl <- read.csv(file, dec=".")
  if("extri" %in% colnames(Empl)) {
    Empl <- Empl %>%
      mutate(EXTRI = extri)
  }
  Empl %>%
    group_by(ANNEE = as.numeric(ANNEE),
             AG, AGQ, S,
             ACT7,
             DIPL = as.numeric(DIPL)) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

# Lecture de tous les fichiers emploi de 1990 à 2002
#Pour que ce code fonctionne, rajouter "4" après "Empl" dans le nom du fichier :
#Exemple : Empl90qi.csv devient Empl490.csv

emploi.raw9002 <- tibble()
for(f in list.files("data/Csv/",pattern = "Empl4", ignore.case = TRUE)) {
  print(f)
  emploi.raw9002 <- bind_rows(emploi.raw9002, read_and_sum(paste0("data/Csv/",f)))
}

# Reformatage des variables avec la commande irec() du package questionr

## Recodage de emploi.raw7581$S en emploi.raw7174$S_rec
emploi.raw9002$S <- emploi.raw9002$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )


## Recodage de emploi.raw9002$ACT7
emploi.raw9002$ACT7 <- emploi.raw9002$ACT7 %>%
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
emploi.raw9002$DIPL <- emploi.raw9002$DIPL %>%
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

emploi9002 <- emploi.raw9002 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7) %>%
  group_by(Annee,Age,AgeQ,Diplome,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

save(emploi.raw9002,emploi9002,file="emploi9002.RData")

#Traitement des données de 2003 à 2020
#Il faut ici ne prendre en compte qu'un trimestre sur les 4 sinon les individus seront
#comptés plusieurs fois et les effectifs ne seront donc pas corrects
#Ici, j'ai choisi (arbitrairement) le premier trimestre et ai renommé tous les fichiers 
#indiv du premier trimestre pour qu'ils commencent par "indiv9"
read_and_sum <- function(file) {
  indiv <- read.csv2(file, dec=".")
  if("extri" %in% colnames(indiv)) {
    indiv <- indiv %>%
      mutate(EXTRI = extri)
  }
  indiv %>%
    group_by(ANNEE = as.numeric(ANNEE),
             AGE, AGEQ, SEXE,
             ACTEU6,
             DIP = as.numeric(DIP)) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

# Lecture de tous les fichiers indiv
emploi.raw0320 <- tibble()
for(f in list.files("data/Csv/",pattern = "indiv9", ignore.case = TRUE)) {
  print(f)
  emploi.raw0320 <- bind_rows(emploi.raw0320, read_and_sum(paste0("data/Csv/",f)))
}


# Reformatage des variables
emploi0320 <- emploi.raw0320 %>%
  mutate(
    Annee = ANNEE,
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = factor(SEXE,levels=c(1,2), labels=c("H","F")),
    Diplome = factor(floor(DIP/10),
                     levels=c(1,2,3,4,5,6,7),
                     labels=c("Bac+5","Bac+3","Bac+2","Bac","CAP-BEP","DNB","Aucun")
    ),
    
    Activite = factor(ACTEU6,
                      levels=c(1,2,3,4,5,6),
                      labels=c(
                        "Actif occupe",
                        "Actif occupe",
                        "Chomeur ou inactif",
                        "Chomeur ou inactif",
                        "Etudiant",
                        "Chomeur ou inactif")
    ) 
  ) %>%
  group_by(Annee,Age,AgeQ,Diplome,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

save(emploi.raw0320,emploi0320,file="emploi0320.RData")

#Chargement de toutes les tables

load("emploi7174.RData")
load("emploi7581.RData")
load("emploi8289.RData")
load("emploi9002.RData")
load("emploi0320.RData")

#Empilement des tables pour en avoir une seule qui a toutes les informations


emploitotal <- rbind(emploi7174, emploi7581, emploi8289, emploi9002, emploi0320)


save(emploitotal, file = "emploitotal.RData")
