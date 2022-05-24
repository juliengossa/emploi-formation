
library(tidyverse)
library(ggcpesrthemes)
theme_cpesr_setup(source="INSEE, enquête emploi en continu 2003-2020")

options(dplyr.summarise.inform = FALSE)

plot_activite <- function(agemin = 15, agemax = 30) {
  emploi %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Annee,Activite) %>%
    summarise(Population = sum(Population)) %>%
    mutate(Activite = factor(Activite,levels=c("Actif occupe","Etudiant","Chomeur ou inactif"))) %>%
    ggplot(aes(x=Annee,y=Population,fill=Activite,group=Activite)) +
    geom_area(color="white") 
}


update.packages(ask = FALSE, checkBuilt = TRUE)
tinytex::tlmgr_update()


