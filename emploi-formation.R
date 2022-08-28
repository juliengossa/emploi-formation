library(tidyverse)
library(ggcpesrthemes)
library(dplyr)
library(ggplot2)
library(gtsummary)
library(survey)

theme_cpesr_setup(source="INSEE, enquête emploi en continu 2003-2020, enquête emploi annuelle 1971 - 2002")

options(dplyr.summarise.inform = FALSE, Encoding="UTF-8")

#Suppression des années problématiques
emploi <- filter(emploi, Annee != 1975 & Annee != 1973)
#Creation d'une table des jeunes sans emploi
SansEmploi <-  filter(emploi, Age > 14 & Age < 30)
SansEmploi <-  group_by(SansEmploi, Annee, Activite)
SansEmploi <-  filter(SansEmploi, Activite == "Chômeur ou inactif")
SansEmploi <- summarise(SansEmploi, Population = sum(Population))

#Creation d'une table sur les jeunes de 15 à 29 ans
Popjeunes <-  filter(emploi, Age > 14 & Age< 30)
Popjeunes <- group_by(Popjeunes, Annee)
Popjeunes <- summarise(Popjeunes, Population = sum(Population))

#Nettoyage
SansEmploi <- filter(SansEmploi, Annee > 1975)
Popjeunes <-  filter(Popjeunes, Annee < 1975 | Annee > 1975)
NEET <- NEET %>% rename(EffNEET = NEET)

#Réalisation de graphiques
plot_activite <- function(agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020, pourcent = Population / sum(Population)*100, Pop = Population) {
  emploi %>%
    filter(Age >= agemin, Age <= agemax, Annee >= anneemin, Annee <= anneemax) %>%
    filter(!is.na(Activite)) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population, na.rm=TRUE)/1e6) %>%
    # mutate(Activite = factor(Activite,
    #                          levels=c("Actif occupé","Etudiant","Chômeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,color=Activite, group=Activite)) +
    geom_area(alpha=0.7) + labs (x = "Année", y = "Effectif des jeunes (millions)", caption = "Source :Enquête Emploi (1971 - 2020)")
}


#Graphique pour connaître le niveau de diplome des jeunes selon l'année civile 
plot_activite3 <- function(agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020) {
  emploi %>%
    filter(Age > agemin, Age < agemax, Annee >= anneemin, Annee <= anneemax) %>%
    group_by(Annee,Diplome) %>%
    summarise(Population = sum(Population)/1e6) %>%
    mutate(Diplome = factor(Diplome,
                            levels=c("Bac+5","Bac+3","Bac+2","Bac","CAP-BEP","DNB","Aucun"))) %>%
    ungroup() %>%
    complete(Annee,Diplome,fill=list(Population = 0)) %>%
    ggplot(aes(x=Annee,y=Population,fill=Diplome,group=Diplome)) +
    geom_area(color="white", alpha=0.6) + labs (x = "Année", y = "Effectif des jeunes (millions)")
}
# Graphique avec pourcentages de la répartition de l'activité selon l'année civile

plot_activite7 <- function(agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020) {
  emploi %>%
    filter(Age > agemin, Age < agemax, Annee >= anneemin, Annee <= anneemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population)) %>%
    mutate(percentage = Population / sum(Population)*100, Activite = factor(Activite,
                                                                        levels=c("Actif occupé","Apprentis", "Etudiant","Chômeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=percentage,fill=Activite,group=Activite)) +
    geom_area(color="white", alpha=0.6) + labs (x = "Année", y = "Part des jeunes (en %)")
}

#Réalisation du graphique des effectifs d'individus selon l'activité avec la table emploiActt
#(plus fiable que la table emploitotal)


#Indication : la table SansEmploi contient le nombre de jeunes chômeurs et inactifs par an, le
#code pour la construire est disponible à la fin du fichier Traitement_sans_DIPL.R





plot_SE2 <- function(agemin = 15, agemax = 30) {
  SansEmploi %>%
    ggplot(aes(x=Annee,y=Population, group = "Enquête Emploi")) +
    geom_line(color="grey45") + labs (x = "Année", y = "Effectif des NEET", title = "NEET (Not in employment, education or training) de 15 à 29 ans", caption = "Source : Enquête Emploi(1976-2020)")
}


#Comparaison des effectifs Eurostat et enquête emploi

plot_activite8 <- function(agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020) {
  emploi %>%
    filter(Age > agemin, Age < agemax, Annee >= anneemin, Annee <= anneemax) %>%
    group_by(Annee,Diplome) %>%
    summarise(Population = sum(Population)) %>%
    filter(!is.na(Diplome)) %>%
    mutate(percentage = Population / sum(Population)*100, Diplome = factor(Diplome,
                                                                       levels=c("Bac+5","Bac+3","Bac+2","Bac","CAP-BEP","DNB","Aucun"))) %>%
    ggplot(aes(x=Annee,y=percentage,fill=Diplome,group=Diplome)) +
    geom_area(color="white", alpha=0.6) + labs (x = "Année", y = "Part des jeunes (en %)")
}

plot_DIP <- function(agemin = 15, agemax = 30) {
  emploi %>%
    filter(Age > agemin, Age < agemax, Annee > 1989) %>%
    group_by(Annee,Diplome) %>%
    summarise(Population = sum(Population)) %>%
    mutate(percentage = Population / sum(Population), Diplome = factor(Diplome,
                                                                       levels=c("Bac+5","Bac+3","Bac+2","Bac","CAP-BEP","DNB","Aucun"))) %>%
    ggplot(aes(x=Annee,y=percentage,fill=Diplome,group=Diplome)) +
    geom_area(color="white", alpha=0.6) + labs (x = "Année", y = "Effectif (pour 1)")
}
#Réalisation des graphiques sur les NEET (source = Eurostat)

plot_NEET <- 
  bind_rows(
    NEET %>%
      transmute(
        Annee = as.numeric(ANNEE),
        Population = EffNEET,
        Source = "Eurostat")
  ) %>%
  ggplot(aes(x=Annee, y=Population, group = Source, color = Source)) + 
  geom_line() +
  scale_color_manual(values = "steelblue3") +
  labs (x = "Année", y = "Effectif des NEET", title = "Les NEET (Not in Employment, Education or Training) de 15 à 29 ans", 
        caption = "Source : Eurostat, 2022 (Labour Force Survey)")

plot_NEET2 <- 
  bind_rows(
    NEET %>%
      transmute(
        Annee = as.numeric(ANNEE),
        Population = PrctNEET,
        Source = "Eurostat")
  ) %>%
  ggplot(aes(x=Annee, y=Population, group = Source, color = Source)) + 
  geom_line() +
  scale_color_manual(values = "steelblue3") +
  labs (x = "Année", y = "Pourcentage de NEET", title = "Les NEET (Not in Employment, Education or Training) de 15 à 29 ans", 
        caption = "Source : Eurostat, 2022 (Labour Force Survey)")



#Comparaison des effectifs totaux des jeunes de 15 à 29 ans (eurostat et enquête Emploi)

NEET <- mutate(NEET, Jeunes = EJ*1000)

plot_jeunes <- 
  bind_rows(
    Popjeunes %>%
      transmute(
        Annee = as.numeric(Annee),
        Population,
        Source = "Enquête Emploi"),
    NEET %>%
      transmute(
        Annee = as.numeric(ANNEE),
        Population = EJ * 1000,
        Source = "Eurostat")
    ) %>%
  ggplot(aes(x=Annee, y=Population, group = Source, color = Source)) + 
  geom_line() +
  scale_color_manual(values = c("grey45","steelblue3")) +
  labs (x = "Année", y = "Effectif des jeunes", title = "Les jeunes de 15 à 29 ans de 1971 à 2021 en France", 
        caption = "Source : Eurostat, 2022 (Labour Force Survey), Enquête Emploi")

#Comparaison des effectifs totaux des jeunes de 15 à 29 ans (Eurostat (Labour Force Survey) = table NEET, enquête Emploi = Popjeunes, recensement = Jeunes_census)
plot_jeunes2 <- 
  bind_rows(
    Popjeunes %>%
      transmute(
        Annee = as.numeric(Annee),
        Population,
        Source = "Enquête Emploi"),
    NEET %>%
      transmute(
        Annee = as.numeric(ANNEE),
        Population = EJ * 1000,
        Source = "Eurostat"),
    Jeunes_census %>%
      transmute(
        Annee = as.numeric(Annee),
        Population = Census_15_29,
        Source = "Recensement"),
  ) %>%
  mutate(Population = Population / 1e6) %>%
  ggplot(aes(x=Annee, y=Population, group = Source, color = Source)) + 
  geom_line() +
  scale_color_manual(values = c("grey45","steelblue3", "aquamarine3")) +
  labs (x = "Année", y = "Effectif des jeunes (millions)", 
        caption = "Source : Eurostat(Labour Force Survey, RP), Enquête Emploi")


#Intégration des apprentis dans le graphique final

Apprentis_total <- function(agemin = 15, agemax = 30) {
  emploi %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population) / 1e6) %>%
    mutate(Activite = factor(Activite,
                             levels=c("Actif occupé","Etudiant","Apprentis", "Chômeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,group=Activite)) +
    geom_area(color="white", alpha=0.6) + labs (x = "Année", y = "Effectif selon le statut (millions)", title = "Les jeunes de 1975 à 2020 selon leur statut", caption = "Source :Enquête Emploi")
}

Apprentis_total2 <- function(agemin = 15, agemax = 30) {
  emploi %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population)) %>%
    mutate(Activite = factor(Activite,
                             levels=c("Actif occupé","Apprentis", "Etudiant","Chômeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,group=Activite)) +
    geom_area(color="white", alpha=0.6) + labs (x = "Année", y = "Effectif selon le statut", title = "Les jeunes de 18 à 21 ans de 1975 à 2020 selon leur statut", caption = "Source :Enquête Emploi")
}

emploiAppr2 <- filter(emploi, Activite == "Apprentis")

plot_Apprentis <- function(agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020) {
  emploiAppr2 %>%
    filter(Age > agemin, Age < agemax, Annee >= anneemin, Annee <= anneemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population)/1000) %>%
    mutate(Activite = factor(Activite,
                             levels=c("Actif occupé","Etudiant","Apprentis", "Chômeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,group=Activite)) +
    geom_line(color = scales::hue_pal()(4)[2]) + 
    expand_limits(y=0) +
    labs (x = "Année", y = "Effectif des apprentis (milliers)", title = "Les apprentis de 1975 à 2020 en France", caption = "Source :Enquête Emploi")
}

emploiAppr3 <- emploi %>% filter(Annee != 2003)

Apprentis_total3 <- function(agemin = 15, agemax = 30) {
  emploiAppr3 %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population) / 1e6) %>%
    mutate(Activite = factor(Activite,
                             levels=c("Actif occupé","Apprentis", "Etudiant","Chômeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,group=Activite)) +
    geom_area(color="white", alpha=0.6) + labs (x = "Année", y = "Effectif selon le statut (millions)", caption = "Source :Enquête Emploi")
}

#30 ans et +
Apprentis_total4 <- function(agemin = 30, agemax = 60) {
  emploi %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population) / 1e6) %>%
    mutate(Activite = factor(Activite,
                             levels=c("Actif occupé","Apprentis", "Etudiant","Chômeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,group=Activite)) +
    geom_area(color="white", alpha=0.6) + labs (x = "Année", y = "Effectif selon le statut (millions)", title = "Les individus de 30 ans à 60 ans de 1975 à 2020 selon leur statut", caption = "Source :Enquête Emploi")
}

#données Emploi.R
Apprentis_total4.5 <- function(agemin = 30, agemax = 60) {
  emploi %>%
    filter(Age > agemin, Age < agemax) %>%
    filter(Annee != 2003) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population)/ 1e6) %>%
    na.omit() %>%
    mutate(Activite = factor(Activite,
                             levels=c("Actif occupé","Apprentis", "Etudiant","Chômeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,group=Activite)) +
    geom_area(color="white", alpha=0.6) + labs (x = "Année", y = "Effectif selon le statut (en millions)", caption = "Source :Enquête Emploi")
}

#Comparaison effectifs des jeunes en formation et actifs occupés
EmploiEtu <- filter(emploi, Age < 30 & Age > 14 & Activite == "Etudiant")
EmploiEtu <- group_by(EmploiEtu, Annee)
EmploiEtu <- summarise(EmploiEtu, Population = sum(Population))

plot_Jeunes_Etudiants <- 
  bind_rows(
    EmploiEtu %>%
      transmute(
        Annee = as.numeric(Annee),
        Population,
        Source = "Enquête Emploi"),
    Jeunes_Actifs_Etudiants %>%
      transmute(
        Annee = as.numeric(Annee),
        Population = EffEducForma,
        Source = "Eurostat")
  ) %>%
  ggplot(aes(x=Annee, y=Population, group = Source, color = Source)) + 
  geom_line() +
  scale_color_manual(values = c("grey45","steelblue3")) +
  labs (x = "Année", y = "Effectif des jeunes étudiants",
        caption = "Source : Eurostat, 2022 (Labour Force Survey), Enquête Emploi")


EmploiActifs <- filter(emploi, Age < 30 & Age > 14, Activite == "Actif occupé" | Activite == "Apprentis", Annee > 1974)
EmploiActifs <- group_by(EmploiActifs, Annee)
EmploiActifs <- summarise(EmploiActifs, Population = sum(Population))

plot_Jeunes_Actifs <- 
  bind_rows(
    EmploiActifs %>%
      transmute(
        Annee = as.numeric(Annee),
        Population,
        Source = "Enquête Emploi"),
    Jeunes_Actifs_Etudiants %>%
      transmute(
        Annee = as.numeric(Annee),
        Population = EffActifsOcc,
        Source = "Eurostat")
  ) %>%
  ggplot(aes(x=Annee, y=Population, group = Source, color = Source)) + 
  geom_line() +
  scale_color_manual(values = c("grey45","steelblue3")) +
  labs (x = "Année", y = "Effectif des jeunes actifs", 
        caption = "Source : Eurostat, 2022 (Labour Force Survey), Enquête Emploi")


Emploijeunes <- filter(emploi, Age < 30 & Age > 14, Annee > 1974)
Emploijeunes <- group_by(Emploijeunes, Annee)
Emploijeunes <- summarise(Emploijeunes, Population = sum(Population))

plot_jeunescomp <- 
  bind_rows(
    Emploijeunes %>%
      transmute(
        Annee = as.numeric(Annee),
        Population,
        Source = "Enquête Emploi"),
    NEET %>%
      transmute(
        Annee = as.numeric(ANNEE),
        Population = EJ * 1000,
        Source = "Eurostat")
  ) %>%
  ggplot(aes(x=Annee, y=Population, group = Source, color = Source)) + 
  geom_line() +
  scale_color_manual(values = c("grey45","steelblue3")) +
  labs (x = "Année", y = "Effectif des jeunes", title = "Les jeunes de 15 à 29 ans de 1971 à 2021 en France", 
        caption = "Source : Eurostat, 2022 (Labour Force Survey), Enquête Emploi (1975 - 2020)")


EmploiNEET <- filter(emploi, Age < 30 & Age > 14 & Activite == "Chômeur ou inactif", Annee > 1974)
EmploiNEET <- group_by(EmploiNEET, Annee)
EmploiNEET <- summarise(EmploiNEET, Population = sum(Population))


plot_NEET4 <- 
  bind_rows(
    EmploiNEET %>%
      transmute(
        Annee = as.numeric(Annee),
        Population,
        Source = "Enquête Emploi"),
    Jeunes_Actifs_Etudiants %>%
      transmute(
        Annee = as.numeric(Annee),
        Population = EffNEET,
        Source = "Eurostat")
  ) %>%
  mutate(Population = Population / 1e6) %>%
  ggplot(aes(x=Annee, y=Population, group = Source, color = Source)) + 
  geom_line() +
  scale_color_manual(values = c("grey45","steelblue3")) +
  labs (x = "Année", y = "Effectif des NEET (millions)", 
        caption = "Source : Eurostat (Labour Force Survey), Enquête Emploi")


Emploichom <- filter(emploi5, Age < 30 & Age > 14 & Activite == "Chomeur", Annee > 1974)
Emploichom <- group_by(Emploichom, Annee)
Emploichom <- summarise(Emploichom, Population = sum(Population))

plot_Chomeurs <- 
  bind_rows(
    Emploichom %>%
      transmute(
        Annee = as.numeric(Annee),
        Population,
        Source = "Enquête Emploi"),
    Jeunes_Actifs_Etudiants %>%
      transmute(
        Annee = as.numeric(Annee),
        Population = Chomeurs,
        Source = "Eurostat")
  ) %>%
  ggplot(aes(x=Annee, y=Population, group = Source, color = Source)) + 
  geom_line() +
  scale_color_manual(values = c("grey45","steelblue3")) +
  labs (x = "Année", y = "Effectif des jeunes chômeurs", 
        caption = "Source : Eurostat, 2022 (Labour Force Survey), Enquête Emploi")

#plot_jeunes2s <- function(agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020) {
  #emploi %>%
    #filter(Age >= agemin, Age <= agemax, Annee >= anneemin, Annee <= anneemax) %>%
    #group_by(Annee) %>%
    #summarise(Population = sum(Population, na.rm=TRUE)) %>%
  #ggplot(aes(x=Annee, y=Population)) + 
  #geom_line() +
  #scale_color_manual(values = "grey45") +
  #labs (x = "Année", y = "Effectif des jeunes", title = "Les jeunes de 15 à 29 ans de 1971 à 2021 en France", 
        #caption = "Source : Enquête Emploi")
#}


### Réalisation des tableaux gtsummary



emploi <- emploi[-113676,]

## Recodage de emploi$Sexe
emploi$Sexe <- emploi$Sexe %>%
  fct_recode(
    "Homme" = "H",
    "Femme" = "F"
  )

emploij <- filter(emploi, Age < 30 & Age > 14)
emploij$Diplome <- fct_explicit_na(emploij$Diplome)
#Définition du plan d'échantillonnage
dw <- svydesign(ids = ~1, data = emploij, weights = ~ Population)
sous <- subset(dw, Annee == "1976" | Annee == "1985" | Annee == "1995" | Annee == "2005" | Annee == "2015"| Annee == "2020")

dw1976 <- subset(dw, Annee == "1976")
dw2020 <- subset(dw, Annee == "2020")

theme_gtsummary_language("fr", decimal.mark = ",", big.mark = " ")


#Activité et diplôme en fonction des périodes
tablemploi <- sous %>% tbl_svysummary(by = "Annee", include = c("Activite", "Diplome")) %>% 
  modify_caption("**Tableau 1. Statut d'activité et niveau de diplôme des jeunes de 15 à 29 ans en fonction des périodes**")

#tableinclude <- dw %>% tbl_svysummary(include = c("Age", "Sexe", "Diplome", "Activite"))



#1976 - Sexe et diplôme en fonction de l'activité
tableacti1976 <- dw1976 %>% tbl_svysummary(by = "Activite", include = c("Sexe", "Age", "Diplome")) %>% 
  modify_caption("**Tableau 2. Sexe, âge et niveau de diplôme des jeunes (15-29 ans) en fonction de leur statut d'activité en 1976**")

#2020 - Sexe et diplôme en fonction de l'activité
tableacti2020 <- dw2020 %>% tbl_svysummary(by = "Activite", include = c("Sexe", "Age", "Diplome")) %>% 
  modify_caption("**Tableau 3. Sexe, âge et niveau de diplôme des jeunes (15-29 ans) en fonction de leur statut d'activité en 2020**")


  
#1976 - Sexe et activité en fonction du diplôme
tabledipl1976 <- dw1976 %>% tbl_svysummary(by = "Diplome", include = c("Sexe", "Activite")) %>% 
  modify_caption("**Tableau 4. Sexe et statut d'activité des jeunes (15- 29 ans) en fonction de leur niveau de diplôme en 1976**")

#2020 - Sexe et activité en fonction du diplôme
tabledipl2020 <- dw2020 %>% tbl_svysummary(by = "Diplome",
                                           include = c("Sexe", "Age", "Activite")) %>% 
  modify_caption("**Tableau 5. Sexe et statut d'activité des jeunes (15- 29 ans) en fonction de leur niveau de diplôme en 2020**")








