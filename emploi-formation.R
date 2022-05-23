
library(tidyverse)
library(gganimate)
library(ggcpesrthemes)
theme_cpesr_setup(source="INSEE, enquête emploi en continu 2003-2020")

options(dplyr.summarise.inform = FALSE)



plot_activite <- function(agemin = 15, agemax = 30) {
  emploi %>%
    filter(Age > agemin, Age < agemax) %>%
    group_by(Année,Activité) %>%
    summarise(Population = sum(Population)) %>%
    mutate(Activité = factor(Activité,levels=c("Actif occupé","Etudiant","Chômeur ou inactif"))) %>%
    ggplot(aes(x=Année,y=Population,fill=Activité,group=Activité)) +
    geom_area(color="white") +
    theme_cpesr()
}
