setwd("C:/Users/camil/Documents/Fac/M1/M1 S2/Stage")

#Les variables DIPL et ACTEU sont des variables qualitatives, il est donc possible de faire 
#régression pour voir le lien entre ces deux variables. 
# Chargement des packages utilises ----
library(tidyverse)
library(questionr)
library(dplyr)
library(readr)

#1974
indiv74 <- read.csv(file = "data/Csv/Empl174qi.csv")

str(indiv74)
freq(indiv74$DIP)
indiv74$CSE <- indiv74$CSE %>%
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


indiv74$DIP <- indiv74$DIP %>%
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

indiv74 <- indiv74 %>%
  mutate(
    Annee = ANNEE,
    Age = AD,
    AgeQ = ADD,
    Sexe = S,
    Diplome = DIP,
    Activite = CSE)
str(indiv74)

indiv74 <- filter(indiv74, Age < 30 & Age > 14)

#1985

indiv85$FI <- indiv85$FI %>%
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

indiv85 <- indiv85 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AQ1,
    Sexe = S,
    Diplome = DIPL,
    Activite = FI) 

indiv85 <- filter(indiv85, Age < 30 & Age > 14)

#1995
indiv95 <- read.csv(file = "data/Csv/Empl495qi.csv")

indiv95$ACT7 <- indiv95$ACT7 %>%
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
indiv95$DIPL <- indiv95$DIPL %>%
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

indiv95 <- indiv95 %>%
  mutate(
    Annee = ANNEE,
    Age = AG,
    AgeQ = AGQ,
    Sexe = S,
    Diplome = DIPL,
    Activite = ACT7)

freq(indiv95$DIPL)

indiv95 <- filter(indiv95, Age < 30 & Age > 14)

#Année 2015
indiv15<- read.csv2(file = "data/Csv/INDIV9151.csv")

indiv15 <- indiv15 %>%
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
    ) )

freq(indiv15$Diplome)

indiv15 <- filter(indiv15, Age < 30 & Age > 14)

###  Réalisation des régressions ###

Model1 <- glm(relevel(Activite, ref ="Actif occupe") ~ relevel(Diplome, ref= "Aucun"),
              data=indiv74,
              family=binomial(logit))

Model3 <- glm(relevel(Activite, ref ="Actif occupe") ~ relevel(Diplome, ref= "Aucun"),
              data=indiv85,
              family=binomial(logit))

Model4 <- glm(relevel(Activite, ref ="Actif occupe") ~ relevel(Diplome, ref= "Aucun"),
              data=indiv95,
              family=binomial(logit))

Model5 <- glm(relevel(Activite, ref ="Actif occupe") ~ relevel(Diplome, ref= "Aucun"),
              data=indiv15,
              family=binomial(logit))



odds.ratio(Model1, level = 0.99)
odds.ratio(Model3, level = 0.99)
odds.ratio(Model4, level = 0.99)
odds.ratio(Model5, level = 0.99)

#Bac+3 pas significatif (p value trop élevée)
#Globalement chez les jeunes, en 1974, toutes choses égales par ailleurs, le fait d'avoir un diplôme
#plutôt que de ne pas en avoir diminue la probabilité d'être étudiant, chômeur ou inactif 
#plutôt qu'actif occupé. De plus, plus le diplôme est élevé, plus la probabilité d'être autre
#chose qu'un actif occupé est faible. Ce phénomène tend à s'intenfier au fil du temps, en effet,
#en 1974, l'odds ratio des bac+5 est proche de 0,28. Il est de 0,18 en 1985 puis de 0,06 en 2015,
#ce qui montre que la probabilité pour un jeune qui a un bac +5 (plutôt qu'aucun diplôme) d'être autre chose qu'un actif occupé
#diminue au fil du temps. On peut ainsi penser qu'un jeune qui en 2015 n'a pas de diplôme aurait davantantage de difficultés
#qu'en 1974 pour devenir un actif occupé.
#Cela va dans le sens de l'analyse de MARTINACHE Igor dans « Les diplômes ont-ils perdu leur valeur ? » (2017)
#qui montre que Les diplômes sont de plus en plus nécessaires mais de moins en moins suffisants pour trouver un emploi qualifié. 


