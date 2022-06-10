#On procède ici à créer des tables qui ne comprennent pas la variable qui informe sur le 
#niveau de diplôme et qui est très mal renseignée, supprimant ainsi de nombreux individus de la table

setwd("C:/Users/camil/Documents/Fac/M1/M1 S2/Stage")

library(tidyverse)
library(dplyr)
library(questionr)
library(readr)

#Démonstration de l'utilité de créer un nouveau fichier sans DIPL

indiv75 <- read.csv(file = "data/Csv/Empl275qi.csv")
indiv75 <- group_by(indiv75, CSE)
freq(indiv75$CSE)
#31,3% des individus interrogés en 1974 n'ont pas indiqué leur niveau de diplôme

indiv74 <- read.csv(file = "data/Csv/Empl174qi.csv")
indiv74 <- group_by(indiv74, DIP)
freq(indiv74$DIP)

#C'est 31,1% de non-réponses pour 1974

indiv88 <- read.csv(file = "data/Csv/Empl388qi.csv")
indiv88 <- group_by(indiv88, DIPL)
freq(indiv88$DIPL)

indiv86 <- read.csv(file = "data/Csv/Empl386qi.csv")
indiv86 <- group_by(indiv86, DIPL)
freq(indiv86$DIPL)

indiv75 <- read.csv(file = "data/Csv/Empl275qi.csv")
indiv75 <- group_by(indiv75, DIP)
freq(indiv75$DIP)

indiv95 <- read.csv(file = "data/Csv/Empl495qi.csv")
indiv95 <- group_by(indiv95, DIPL)
freq(indiv95$DIPL)

#En 1988, on atteint "seulement 14,1% de non réponses mais encore trop fragile pour 
#comparer efficacement les effectifs d'individus selon l'année et le niveau de diplôme


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
             CSE) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

# Lecture de tous les fichiers emploi de 1971 à 1974
#Pour que ce code fonctionne, rajouter "1" après "Empl" dans le nom du fichier :
#Exemple : Empl74qi.csv devient Empl174.csv

emploi.raw1 <- tibble()
for(f in list.files("data/Csv/",pattern = "Empl1", ignore.case = TRUE)) {
  print(f)
  emploi.raw1 <- bind_rows(emploi.raw1, read_and_sum(paste0("data/Csv/",f)))
}


# Reformatage des variables avec la commande irec() du package questionr


## Recodage de emploi.raw7174$S en emploi.raw7174$S_rec
emploi.raw1$S <- emploi.raw1$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )



## Recodage de emploi.raw7174$CSE

emploi.raw1$CSE <- emploi.raw1$CSE %>%
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



emploi1 <- emploi.raw1 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = ADD,
    Sexe = S,
    Activite = CSE) %>%
  group_by(Annee,Age,AgeQ,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()


save(emploi.raw1,emploi1,file="emploi1.RData")


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
             FI) %>%
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


## Recodage de emploi.raw7581$S en emploi.raw7174$S_rec
emploi.raw2$S <- emploi.raw2$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )

## Recodage de emploi.raw7581$FI
emploi.raw2$FI <- emploi.raw2$FI %>%
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
    Activite = FI) %>%
  group_by(Annee,Age,AgeQ,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

save(emploi.raw2,emploi2,file="emploi2.RData")

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
             FI) %>%
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

## Recodage de emploi.raw8289$S 
emploi.raw3$S <- emploi.raw3$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )

## Recodage de emploi.raw7581$FI
emploi.raw3$FI <- emploi.raw3$FI %>%
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
    Activite = FI) %>%
  group_by(Annee,Age,AgeQ,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

save(emploi.raw3,emploi3,file="emploi3.RData")


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
             ACT7) %>%
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

## Recodage de emploi.raw7581$S en emploi.raw7174$S_rec
emploi.raw4$S <- emploi.raw4$S %>%
  as.character() %>%
  fct_recode(
    "H" = "1",
    "F" = "2"
  )


## Recodage de emploi.raw9002$ACT7
emploi.raw4$ACT7 <- emploi.raw4$ACT7 %>%
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
    Activite = ACT7) %>%
  group_by(Annee,Age,AgeQ,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

save(emploi.raw4,emploi4,file="emploi4.RData")

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
             ACTEU6) %>%
    summarise(Population = sum(EXTRI,na.rm=TRUE))
}

# Lecture de tous les fichiers indiv
emploi.raw5 <- tibble()
for(f in list.files("data/Csv/",pattern = "indiv9", ignore.case = TRUE)) {
  print(f)
  emploi.raw5 <- bind_rows(emploi.raw5, read_and_sum(paste0("data/Csv/",f)))
}


# Reformatage des variables
emploi5 <- emploi.raw5 %>%
  mutate(
    Annee = ANNEE,
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = factor(SEXE,levels=c(1,2), labels=c("H","F")),
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
  group_by(Annee,Age,AgeQ,Activite,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()

save(emploi.raw5,emploi5,file="emploi5.RData")

#Chargement de toutes les tables

load("emploi1.RData")
load("emploi2.RData")
load("emploi3.RData")
load("emploi4.RData")
load("emploi5.RData")

#Empilement des tables pour en avoir une seule qui a toutes les informations


emploiAct <- rbind(emploi1, emploi2, emploi3, emploi4, emploi5)


save(emploiAct, file = "emploiact.RData")

#Je crée une table qui contient le nombre de chomeur et inactifs de 15 à 29 ans chaque année

emploiAct2 <-  filter(emploiAct, Age > 14 & Age< 30)
emploiAct2 <-  group_by(emploiAct2, Annee, Activite)
SansEmploi <- summarise(emploiAct2, Population = sum(Population))

SansEmploi <-  filter(SansEmploi, Activite == "Chomeur ou inactif")

save(SansEmploi, file = "sansemploi.RData")


emploiAct3 <-  filter(emploiAct, Age > 14 & Age< 30)
emploiAct3 <- group_by(emploiAct3, Annee)
Popjeunes <- summarise(emploiAct3, Population = sum(Population))

save(Popjeunes, file = "popjeunes.RData")
