Chargement des données
================

``` r
# Les données doivent être dans un dossier "data/Csv/"
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
emploi.raw <- tibble()
for(f in list.files("data/Csv",pattern = "indiv", ignore.case = TRUE)) {
  print(f)
  emploi.raw <- bind_rows(emploi.raw, read_and_sum(paste0("data/Csv/",f)))
}
```

\[1\] “indiv031.csv” \[1\] “indiv032.csv” \[1\] “indiv033.csv” \[1\]
“indiv034.csv” \[1\] “indiv041.csv” \[1\] “indiv042.csv” \[1\]
“indiv043.csv” \[1\] “indiv044.csv” \[1\] “indiv051.csv” \[1\]
“indiv052.csv” \[1\] “indiv053.csv” \[1\] “indiv054.csv” \[1\]
“indiv061.csv” \[1\] “indiv062.csv” \[1\] “indiv063.csv” \[1\]
“indiv064.csv” \[1\] “indiv071.csv” \[1\] “indiv072.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “indiv073.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “indiv074.csv” \[1\] “indiv081.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “indiv082.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “indiv083.csv” \[1\] “indiv084.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “indiv091.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “indiv092.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “indiv093.csv”

    ## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec = dec, :
    ## caractère(s) 'nul' au milieu de l'entrée

\[1\] “indiv094.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “indiv101.csv” \[1\] “indiv102.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “indiv103.csv” \[1\] “indiv104.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV111.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV112.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV113.csv” \[1\] “INDIV114.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV121.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV122.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV123.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV124.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV131.csv” \[1\] “INDIV132.csv” \[1\] “INDIV133.csv” \[1\]
“INDIV134.csv” \[1\] “INDIV141.csv” \[1\] “INDIV142.csv” \[1\]
“INDIV143.csv” \[1\] “INDIV144.csv” \[1\] “INDIV151.csv” \[1\]
“INDIV152.csv” \[1\] “INDIV153.csv” \[1\] “INDIV154.csv” \[1\]
“INDIV161.csv” \[1\] “INDIV162.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV163.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV164.csv”

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

\[1\] “INDIV171.csv” \[1\] “INDIV172.csv” \[1\] “INDIV173.csv” \[1\]
“INDIV174.csv” \[1\] “INDIV181.csv” \[1\] “INDIV182.csv” \[1\]
“INDIV183.csv” \[1\] “INDIV184.csv” \[1\] “INDIV191.csv” \[1\]
“INDIV192.csv” \[1\] “INDIV193.csv” \[1\] “INDIV194.csv” \[1\]
“INDIV201.csv” \[1\] “INDIV202.csv” \[1\] “INDIV203.csv” \[1\]
“INDIV204.csv”

``` r
# Reformatage des variables
emploi <- emploi.raw %>%
  mutate(
    Année = ANNEE,
    Age = AGE,
    AgeQ = AGEQ,
    Sexe = factor(SEXE,levels=c(1,2), labels=c("H","F")),
    Diplome = factor(floor(DIP/10),
                     levels=c(1,2,3,4,5,6,7),
                     labels=c("Bac+5","Bac+3","Bac+2","Bac","CAP-BEP","DNB","Aucun")
                     ),

    Activité = factor(ACTEU6,
                      levels=c(1,2,3,4,5,6),
                      labels=c(
                        "Actif occupé",
                        "Actif occupé",
                        "Chômeur ou inactif",
                        "Chômeur ou inactif",
                        "Etudiant",
                        "Chômeur ou inactif")
                      ) 
  ) %>%
  group_by(Année,Age,AgeQ,Diplome,Activité,) %>%
  summarise(Population = as.integer(sum(Population,na.rm=TRUE))) %>%
  na.omit()
```

``` r
save(emploi.raw,emploi,file="emploi.RData")
```
