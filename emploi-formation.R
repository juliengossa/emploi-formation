
library(tidyverse)
library(ggcpesrthemes)
library(dplyr)
library(ggplot2)

theme_cpesr_setup(source="INSEE, enquête emploi en continu 2003-2020, enquête emploi annuelle 1971 - 2002")

options(dplyr.summarise.inform = FALSE, Encoding="UTF-8")

emploitotal <-  filter(emploitotal, Annee < 1975 | Annee > 1975)
emploiAct <-  filter(emploiAct, Annee < 1975 | Annee > 1975)
SansEmploi <- filter(SansEmploi, Annee < 1975 | Annee > 1975)

plot_activite <- function(agemin = 15, agemax = 30) {
  emploi %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population)) %>%
    mutate(Activite = factor(Activite,
                             levels=c("Actif occupé","Etudiant","Chômeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,group=Activite)) +
    geom_area(color="white") 
}


plot_activite2 <- function(agemin = 15, agemax = 30) {
  emploitotal %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population)) %>%
    mutate(Activite = factor(Activite,
                             levels=c("Actif occupe","Etudiant","Chomeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,group=Activite)) +
    geom_area(color="white") 
}

#Graphique pour connaître le niveau de diplome des jeunes selon l'année civile 
plot_activite3 <- function(agemin = 15, agemax = 30) {
  emploitotal %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Diplome) %>%
    summarise(Population = sum(Population)) %>%
    mutate(Diplome = factor(Diplome,
                             levels=c("Bac+5","Bac+3","Bac+2","Bac","CAP-BEP","DNB","Aucun"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Diplome,group=Diplome)) +
    geom_area(color="white") 
}
# Graphique avec pourcentages de la répartition de l'activité selon l'année civile

plot_activite7 <- function(agemin = 15, agemax = 30) {
  emploiAct %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population)) %>%
    mutate(percentage = Population / sum(Population), Activite = factor(Activite,
                             levels=c("Actif occupe","Etudiant","Chomeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=percentage,fill=Activite,group=Activite)) +
    geom_area(color="white") 
}

#Réalisation du graphique des effectifs d'individus selon l'activité avec la table emploiActt
#(plus fiable que la table emploitotal)
plot_activite4 <- function(agemin = 15, agemax = 30) {
  emploiAct %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population)) %>%
    mutate(Activite = factor(Activite,
                             levels=c("Actif occupe","Etudiant","Chomeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,group=Activite)) +
    geom_area(color="white") 
}

#Indication : la table SansEmploi contient le nombre de jeunes chômeurs et inactifs par an, le
#code pour la construire est disponible à la fin du fichier Traitement_sans_DIPL.R
plot_SE2 <- function(agemin = 15, agemax = 30) {
  SansEmploi %>%
  ggplot(aes(x=Annee,y=Population)) +
  geom_line(color="navy")
}

plot_activite8 <- function(agemin = 15, agemax = 30) {
  emploitotal %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Diplome) %>%
    summarise(Population = sum(Population)) %>%
    mutate(percentage = Population / sum(Population), Diplome = factor(Diplome,
                                                                        levels=c("Bac+5","Bac+3","Bac+2","Bac","CAP-BEP","DNB","Aucun"))) %>%
    ggplot(aes(x=Annee,y=percentage,fill=Diplome,group=Diplome)) +
    geom_area(color="white") 
}

NEET <- rename(NEET, "EffNEET" = "NEET")


plot_NEET <- NEET %>% ggplot(aes(x=as.numeric(ANNEE),y=EffNEET)) + geom_line(color="navy") + labs (x = "Année", y = "Effectif des NEET", title = "NEET (Not in employment, education or training) de 15 à 29 ans", caption = "Source : Eurostat, 2022 (Labor Force Survey)")
