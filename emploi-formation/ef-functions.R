library(tidyverse)
load("../emploi.RData")

plot_categorie <- function(categorie="Activite", agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020, fill=FALSE, keep_na=FALSE) {
  if(fill) {
    position_geom <- "fill"
    label_scale <- scales::percent
    title_y <- "Pourcentage de la population"
  } else {
    position_geom <- "stack"
    label_scale <- function(x) x/1e6
    title_y <- "Effectif (millions)"
  }
  
  emploi %>%
    filter(Age >= agemin, Age <= agemax, Annee >= anneemin, Annee <= anneemax) %>%
    #filter(!is.na(Activite)) %>%
    group_by(Annee, Categorie=!!as.name(categorie)) %>%
    summarise(Population = sum(Population, na.rm=TRUE)) %>%
    { if (keep_na) na.omit(.) else . } %>%
    ungroup() %>%
    complete(Annee, Categorie, fill = list(Population = 0)) %>%
    ggplot(aes(x=Annee,y=Population,fill=Categorie,color=Categorie, group=Categorie)) +
    geom_area(alpha=0.7, position = position_geom) + 
    scale_y_continuous(labels = label_scale) +
    labs (x = "Année", y = title_y, caption = "Source :Enquête Emploi (1971 - 2020)")
}


## Graphique activité par tranche 
plot_categorie_slice <- function(categorie="Activite", agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020, fill=FALSE, keep_na=FALSE) {
  if(fill) {
    position_geom <- "fill"
    label_scale <- scales::percent
    title_y <- "Pourcentage de la population"
  } else {
    position_geom <- "stack"
    label_scale <- function(x) x/1e6
    title_y <- "Effectif (millions)"
  }
  
  emploi %>%
    filter(Age >= agemin, Age <= agemax, Annee %in% c(anneemin,anneemax)) %>%
    #filter(!is.na(Activite)) %>%
    group_by(Annee, Age, Categorie=!!as.name(categorie)) %>%
    summarise(Population = sum(Population, na.rm=TRUE)) %>%
    { if (keep_na) na.omit(.) else . } %>%
    ungroup() %>%
    complete(Annee, Categorie, fill = list(Population = 0)) %>%
    ggplot(aes(x=Age,y=Population,fill=Categorie, group=Categorie)) +
    geom_col(alpha=0.7, position = position_geom, color="black",width = 1) + 
    facet_grid(.~Annee) +
    scale_y_continuous(labels = label_scale) +
    labs (x = "Age", y = title_y, caption = "Source :Enquête Emploi (1971 - 2020)")
}


## Graphique activité par tranche 
plot_categorie_ponctuel <- function(categorie="Activite", agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020, fill=FALSE, keep_na=FALSE) {
  if(fill) {
    position_geom <- "fill"
    label_scale <- scales::percent
    title_y <- "Pourcentage de la population"
  } else {
    position_geom <- "stack"
    label_scale <- function(x) x/1e6
    title_y <- "Effectif (millions)"
  }
  
  emploi %>%
    filter(Age >= agemin, Age <= agemax, Annee %in% c(anneemin,anneemax)) %>%
    #filter(!is.na(Activite)) %>%
    group_by(Annee, Categorie=!!as.name(categorie)) %>%
    summarise(Population = sum(Population, na.rm=TRUE)) %>%
    { if (keep_na) na.omit(.) else . } %>%
    { if (fill) group_by(.,Annee) %>% mutate(Population = Population / sum(Population)) else . } %>%
    ungroup() %>%
    complete(Annee, Categorie, fill = list(Population = 0)) %>%
    ggplot(aes(x=Categorie,y=Population,fill=Categorie, group=Categorie)) +
    geom_col(alpha=0.7, color="black",width = 1) + 
    facet_grid(.~Annee) +
    scale_y_continuous(labels = label_scale) +
    labs (x = "Age", y = title_y, caption = "Source :Enquête Emploi (1971 - 2020)")
}

