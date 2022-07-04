library(tidyverse)
library(readr)
library(FactoMineR)
library(factoextra)
library(openxlsx)
library(tibble)
library(dplyr)
library(tidyr)

setwd("C:/Users/camil/Documents/Fac/M1/M1 S2/Stage/Emploiformation")

e1976 <- read.csv("../data/Csv/Empl276qi.csv")
e1990 <- read.csv("../data/Csv/Empl490qi.csv")
e2020 <- read.csv2("../data/Csv/INDIV9201.csv")

e1976 <- e1976 %>% filter(AD < 30 & AD > 14)


e1976 <- e1976 %>% select(S, DIP, FI)  

e1976$DIP <- e1976$DIP %>%
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

## Recodage de emploi.raw7581$S en emploi.raw7174$S_rec
e1976$S <- e1976$S %>%
  as.character() %>%
  fct_recode(
    "Homme" = "1",
    "Femme" = "2"
  )

## Recodage de emploi.raw7581$FI
e1976$FI <- e1976$FI %>%
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


e1976 <- rename(e1976, "Activite" = "FI", "Sexe" = "S", "Diplome" = "DIP")






ACM <- MCA(e1976, graph = FALSE)



get_eig(ACM)
1/12
#Normalement il faudrait dépouiller 8 axes

EG <- data.frame(get_eig(ACM))
#6 dimensions en tout donc : 
EG <- slice(EG,1:8)

EG <- EG %>% mutate(EG_aj = ((3/2)^2)*(eigenvalue-(1/3))^2)

#c est le critère d'arrêt
c <- sum(EG$EG_aj)/8

round(EG$EG_aj, digits = 4)
#il n'y a que la 1ère qui est au-dessus de c mais on doit prendre 
#également la 2ème dimension. 

fviz_contrib(ACM,
             choice = "var",
             axes = 1)

fviz_contrib(ACM,
             choice = "var",
             axes = 2)
get_mca_var(ACM)$contrib[,1:2]

get_mca_var(ACM)$coord[,1:2]

#On fait le cos2 pour savoir quelles variables et modalit?s ne sont pas assez significatives
#pour ?tre gard?es. 
fviz_cos2(ACM,
          choice = "var",
          axes = 1)

fviz_cos2(ACM,
          choice = "var",
          axes = 2)
#Tout ce qui est en lien avec les diplômes est bancal en 1976. 

fviz_cos2(ACM,
          choice = "var",
          axes = 1:2)

fviz_mca_var(ACM,
            repel = TRUE,
            col.var = "cos2",
            title = "Analyse en composantes principales - 1976")


### 1990 ###


e1990 <- e1990 %>% filter(AG < 30 & AG > 14)
e1990 <- e1990 %>% select(S, DIPL, ACT7)


e1990$S <- e1990$S %>%
  as.character() %>%
  fct_recode(
    "Homme" = "1",
    "Femme" = "2"
  )


## Recodage de emploi.raw9002$ACT7
e1990$ACT7 <- e1990$ACT7 %>%
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
e1990$DIPL <- e1990$DIPL %>%
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

e1990 <- rename(e1990, "Activite" = "ACT7", "Sexe" = "S", "Diplome" = "DIPL")


ACM2 <- MCA(e1990, graph = FALSE)



get_eig(ACM2)
1/10
#Normalement il faudrait dépouiller 10 axes

fviz_contrib(ACM2,
             choice = "var",
             axes = 1)

fviz_contrib(ACM2,
             choice = "var",
             axes = 2)
get_mca_var(ACM2)$contrib[,1:2]

get_mca_var(ACM2)$coord[,1:2]

#On fait le cos2 pour savoir quelles variables et modalit?s ne sont pas assez significatives
#pour ?tre gard?es. 
fviz_cos2(ACM2,
          choice = "var",
          axes = 1)

fviz_cos2(ACM2,
          choice = "var",
          axes = 2)
#Tout ce qui est en lien avec les diplômes est bancal en 1976. 

fviz_cos2(ACM2,
          choice = "var",
          axes = 1:2)


fviz_mca_var(ACM2,
             repel = TRUE,
             col.var = "cos2",
             title = "Analyse en composantes principales - 1990")




### 2020 ###


e2020 <- e2020 %>% filter(AGE < 30 & AGE > 14)
e2020 <- e2020 %>% select(SEXE, DIP, ACTEU6)

e2020 <- rename(e2020, "Activite" = "ACTEU6", "Sexe" = "SEXE", "Diplome" = "DIP")


e2020$Sexe <- e2020$Sexe %>%
  as.character() %>%
  fct_recode(
    "Homme" = "1",
    "Femme" = "2"
  )


## Recodage de emploi.raw9002$ACT7
e2020$Activite <- e2020$Activite %>%
  as.character() %>%
  fct_recode(
    "Actif occupe" = "1",
    "Chomeur ou inactif" = "3",
    "Chomeur ou inactif" = "4",
    "Etudiant" = "5",
    "Chomeur ou inactif" = "6",
    NULL = "NR",
  )

## Recodage de emploi.raw9002$DIPL
e2020$Diplome <- e2020$Diplome %>%
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
    "Aucun" = "71",
    NULL = "NR",
  )


e2020 <- filter(e2020, Activite != "NR")
e2020 <- filter(e2020, Diplome != "NR")


ACM3 <- MCA(e2020, graph = FALSE)



get_eig(ACM3)
1/10
#Normalement il faudrait dépouiller 10 axes

fviz_contrib(ACM3,
             choice = "var",
             axes = 1)

fviz_contrib(ACM3,
             choice = "var",
             axes = 2)

get_mca_var(ACM3)$contrib[,1:2]

get_mca_var(ACM3)$coord[,1:2]

#On fait le cos2 pour savoir quelles variables et modalit?s ne sont pas assez significatives
#pour ?tre gard?es. 
fviz_cos2(ACM3,
          choice = "var",
          axes = 1)

fviz_cos2(ACM3,
          choice = "var",
          axes = 2)
#Tout ce qui est en lien avec les diplômes est bancal en 1976. 

fviz_cos2(ACM3,
          choice = "var",
          axes = 1:2)


fviz_mca_var(ACM3,
             repel = TRUE,
             col.var = "cos2",
             title = "Analyse en composantes principales - 2020")

### En enlevant les étudiants ###
#1976#
e1976 <- filter(e1976, Activite != "Etudiant")

ACM5 <- MCA(e1976, graph = FALSE)



get_eig(ACM5)
1/10
#Normalement il faudrait dépouiller 10 axes

fviz_contrib(ACM5,
             choice = "var",
             axes = 1)

fviz_contrib(ACM5,
             choice = "var",
             axes = 2)

get_mca_var(ACM5)$contrib[,1:2]

get_mca_var(ACM5)$coord[,1:2]

#On fait le cos2 pour savoir quelles variables et modalit?s ne sont pas assez significatives
#pour ?tre gard?es. 
fviz_cos2(ACM5,
          choice = "var",
          axes = 1)

fviz_cos2(ACM5,
          choice = "var",
          axes = 2)
#Tout ce qui est en lien avec les diplômes est bancal en 1976. 

fviz_cos2(ACM5,
          choice = "var",
          axes = 1:2)


fviz_mca_var(ACM5,
             repel = TRUE,
             col.var = "cos2",
             title = "Analyse en composantes principales - 1976")



#1990#
e1990 <- filter(e1990, Activite != "Etudiant")

ACM6 <- MCA(e1990, graph = FALSE)



get_eig(ACM6)
1/10
#Normalement il faudrait dépouiller 10 axes

fviz_contrib(ACM6,
             choice = "var",
             axes = 1)

fviz_contrib(ACM6,
             choice = "var",
             axes = 2)

get_mca_var(ACM6)$contrib[,1:2]

get_mca_var(ACM6)$coord[,1:2]

#On fait le cos2 pour savoir quelles variables et modalit?s ne sont pas assez significatives
#pour ?tre gard?es. 
fviz_cos2(ACM6,
          choice = "var",
          axes = 1)

fviz_cos2(ACM6,
          choice = "var",
          axes = 2)
#Tout ce qui est en lien avec les diplômes est bancal en 1976. 

fviz_cos2(ACM6,
          choice = "var",
          axes = 1:2)


fviz_mca_var(ACM6,
             repel = TRUE,
             col.var = "cos2",
             title = "Analyse en composantes principales - 1990")

##2020 Sans étudiants

e2020 <- filter(e2020, Activite != "Etudiant")

ACM4 <- MCA(e2020, graph = FALSE)



get_eig(ACM4)
1/10
#Normalement il faudrait dépouiller 10 axes

fviz_contrib(ACM4,
             choice = "var",
             axes = 1)

fviz_contrib(ACM4,
             choice = "var",
             axes = 2)

get_mca_var(ACM4)$contrib[,1:2]

get_mca_var(ACM4)$coord[,1:2]

#On fait le cos2 pour savoir quelles variables et modalit?s ne sont pas assez significatives
#pour ?tre gard?es. 
fviz_cos2(ACM4,
          choice = "var",
          axes = 1)

fviz_cos2(ACM4,
          choice = "var",
          axes = 2)
#Tout ce qui est en lien avec les diplômes est bancal en 1976. 

fviz_cos2(ACM4,
          choice = "var",
          axes = 1:2)


fviz_mca_var(ACM4,
             repel = TRUE,
             col.var = "cos2",
             title = "Analyse en composantes principales - 2020")




