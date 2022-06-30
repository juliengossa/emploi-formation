load("../emploi.RData")

plot_activite <- function(agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020, fill=FALSE, keep_na=FALSE) {
  if(fill) {
    position_geom <- "fill"
    label_scale <- scales::percent
  } else {
    position_geom <- "stack"
    label_scale <- function(x) x/1e6
  }
  
  emploi %>%
    filter(Age >= agemin, Age <= agemax, Annee >= anneemin, Annee <= anneemax) %>%
    #filter(!is.na(Activite)) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population, na.rm=TRUE)) %>%
    { if (keep_na) na.omit(.) else . } %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,color=Activite, group=Activite)) +
    geom_area(alpha=0.7, position = position_geom) + 
    scale_y_continuous(labels = label_scale) +
    labs (x = "Année", y = "Effectif des jeunes (millions)", caption = "Source :Enquête Emploi (1971 - 2020)")
}


## Graphique activité par tranche 
plot_activite_slice <- function(agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020, fill=FALSE, keep_na=FALSE) {
  if(fill) {
    position_geom <- "fill"
    label_scale <- scales::percent
  } else {
    position_geom <- "stack"
    label_scale <- function(x) x/1e6
  }
  
  emploi %>%
    filter(Age >= agemin, Age <= agemax, Annee %in% c(anneemin,anneemax)) %>%
    #filter(!is.na(Activite)) %>%
    group_by(Annee,Age,Activite) %>%
    summarise(Population = sum(Population, na.rm=TRUE)) %>%
    { if (keep_na) na.omit(.) else . } %>%
    ggplot(aes(x=Age,y=Population,fill=Activite, group=Activite)) +
    geom_col(alpha=0.7, position = position_geom, color="black",width = 1) + 
    facet_grid(.~Annee) +
    scale_y_continuous(labels = label_scale) +
    labs (x = "Année", y = "Effectif des jeunes (millions)", caption = "Source :Enquête Emploi (1971 - 2020)")
}

plot_activite_slice()


#Graphique pour connaître le niveau de diplome des jeunes selon l'année civile 
plot_diplome <- function(agemin = 15, agemax = 30, anneemin = 1971, anneemax = 2020, fill=FALSE, keep_na=FALSE) {
  if(fill) {
    position_geom <- "fill"
    label_scale <- scales::percent
  } else {
    position_geom <- "stack"
    label_scale <- function(x) x/1e6
  }
  
  emploi %>%
    filter(Age > agemin, Age < agemax, Annee >= anneemin, Annee <= anneemax) %>%
    group_by(Annee,Diplome) %>%
    summarise(Population = sum(Population)) %>%
    { if (keep_na) na.omit(.) else . } %>%
    mutate(Diplome = factor(Diplome,
                            levels=c("Bac+5","Bac+3","Bac+2","Bac","CAP-BEP","DNB","Aucun"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Diplome,group=Diplome)) +
    geom_area(color="white", position = position_geom) + 
    scale_y_continuous(labels = label_scale) +
    labs (x = "Année", y = "Effectif des jeunes (millions)")
}
