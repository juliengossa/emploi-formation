Chargement des données
================

## Fonctions de lecture

### 1971-1974

``` r
read_and_sum_71_74 <- function(file, annee) {
  Empl <- haven::read_dta(file)
  volumetrie <<- bind_rows(volumetrie,tibble(Annee=annee,Variables=ncol(Empl),Observations=nrow(Empl)))
  Empl %>%
    group_by(Annee = annee,
             Sexe = fct_recode(s,!!!var_recode_sexe),
             Age = as.numeric(ad), 
             Activite = fct_recode(cse,!!!var_recode_CSE),
             Diplome = fct_recode(dip,!!!var_recode_DIP_1975)
    ) %>%
    summarise(Population = sum(extri,na.rm=TRUE))
}

# df <- read_and_sum_71_74("data/Csv/empl71qi.dta", 1971)
```

### 1975-1981

``` r
read_and_sum_75_81 <- function(file, annee) {
  Empl <- haven::read_dta(file)
  volumetrie <<- bind_rows(volumetrie,tibble(Annee=annee,Variables=ncol(Empl),Observations=nrow(Empl)))
  Empl %>%
    group_by(Annee = annee,
             Sexe = fct_recode(s,!!!var_recode_sexe),
             Age = as.numeric(ad), 
             Activite = fct_recode(fi,!!!var_recode_FI),
             Apprentissage = fct_recode(st,!!!var_recode_ST),
             Diplome = fct_recode(dip,!!!var_recode_DIP_1975)
    ) %>%
    summarise(Population = sum(extrin,na.rm=TRUE))
}

# df <- read_and_sum_75_81("data/Csv/empl75qi.dta", 1975)
```

### 1982-1989

``` r
read_and_sum_82_89 <- function(file, annee) {
  Empl <- haven::read_dta(file)
  volumetrie <<- bind_rows(volumetrie,tibble(Annee=annee,Variables=ncol(Empl),Observations=nrow(Empl)))
  Empl %>%
    group_by(Annee = annee,
             Sexe = fct_recode(s,!!!var_recode_sexe),
             Age = as.numeric(ag), 
             Activite = fct_recode(fi,!!!var_recode_FI),
             Apprentissage = fct_recode(statut,!!!var_recode_STATUT),
             Diplome = fct_recode(dipl,!!!var_recode_DIPL)
    ) %>%
    summarise(Population = sum(extri,na.rm=TRUE))
}

#df82 <- read_and_sum_82_89("data/Csv/empl82qi.dta", 1982)
```

### 1990-2002

``` r
read_and_sum_90_02 <- function(file, annee) {
  Empl <- haven::read_dta(file, encoding = "latin1")
  volumetrie <<- bind_rows(volumetrie,tibble(Annee=annee,Variables=ncol(Empl),Observations=nrow(Empl)))
  Empl %>%
    group_by(Annee = annee,
             Sexe = fct_recode(s,!!!var_recode_sexe),
             Age = as.numeric(ag), 
             Activite = fct_recode(act7,!!!var_recode_ACT7),
             Apprentissage = fct_recode(statut,!!!var_recode_STATUT90),
             Diplome = fct_recode(dipl,!!!var_recode_DIPL)
    ) %>%
    summarise(Population = sum(extri,na.rm=TRUE))
}

# df <- read_and_sum_90_02("data/Csv/empl91qi.dta", 1991)
```

## 2003-

``` r
# Les données doivent être dans un dossier "data/Csv/"
read_and_sum_2003_ <- function(file, annee=NA) {
  indiv <- read.csv2(file, dec=".") %>%
    rename_with(toupper)
  volumetrie <<- bind_rows(volumetrie,tibble(Annee=annee,Variables=ncol(indiv),Observations=nrow(indiv)))
  if("EXTRI16" %in% colnames(indiv)) indiv <- indiv %>% rename(EXTRIDF = EXTRI16)
  if(!"FC5A" %in% colnames(indiv)) indiv$FC5A <- ifelse(indiv$STATUTR == 3,1,-1)
  indiv %>%
    group_by(Annee = as.numeric(ANNEE),
             Trimestre = as.numeric(TRIM),
             Age = as.numeric(AGE), 
             Sexe = fct_recode(as.character(SEXE), !!!var_recode_sexe),
             Activite = fct_recode(as.character(ACTEU6), !!!var_recode_ACTUE6),
             Apprentissage = ifelse(FC5A==1 | STATUTR == 3, "Apprentis", "Non apprentis"), #fct_recode(as.character(STATUTR), !!!var_recode_STATUTR),
             Diplome = fct_recode(as.character(DIP), !!!var_recode_DIP_2003)
             #Diplome = factor(floor(as.numeric(DIP)/10),
             #                  levels=c(1,2,3,4,5,6,7),
             #                  labels=c("Bac+5","Bac+3","Bac+2","Bac","CAP-BEP","DNB","Aucun")
             #                  )
             #Salaire = fct_recode(SALREDTR, !!!var_recode_SALREDTR)
             ) %>%
    summarise(
      Population = sum(EXTRI,na.rm=TRUE)
      #EXTRIDF = sum(EXTRIDF,na.rm=TRUE),
      )
}

# df <- read_and_sum_2003_("data/Csv/indiv031.csv")
```

# Lecture de tous les fichiers indiv

``` r
test <- FALSE

dir <- "data/Csv/"
emploi.raw <- tibble()
volumetrie <- tibble()

for(a in seq(71,74)) {
  print(a)
  emploi.raw <- bind_rows(emploi.raw, read_and_sum_71_74(paste0(dir,"empl",a,"qi.dta"), annee = 1900+a))
  if(test) break
} 
```

    ## [1] 71
    ## [1] 72
    ## [1] 73

    ## Warning: Unknown levels in `f`: 10, 21, 22, 30, 31, 32, 33, 40, 41, 42, 43, 44,
    ## 45, 46, 50, 51, 52, 53, 54, 60, 61

    ## [1] 74

``` r
for(a in seq(75,81)) {
  print(a)
  emploi.raw <- bind_rows(emploi.raw, read_and_sum_75_81(paste0(dir,"empl",a,"qi.dta"), annee = 1900+a))
  if(test) break
}
```

    ## [1] 75

    ## Warning: Unknown levels in `f`: 8

    ## [1] 76

    ## Warning: Unknown levels in `f`: 8

    ## [1] 77

    ## Warning: Unknown levels in `f`: 8

    ## [1] 78

    ## Warning: Unknown levels in `f`: 8

    ## [1] 79

    ## Warning: Unknown levels in `f`: 8

    ## [1] 80

    ## Warning: Unknown levels in `f`: 8

    ## [1] 81

    ## Warning: Unknown levels in `f`: 8

``` r
for(a in seq(82,89)) {
  print(a)
  emploi.raw <- bind_rows(emploi.raw, read_and_sum_82_89(paste0(dir,"empl",a,"qi.dta"), annee = 1900+a))
  if(test) break
} 
```

    ## [1] 82

    ## Warning: Unknown levels in `f`: 01

    ## [1] 83
    ## [1] 84

    ## Warning: Unknown levels in `f`: 01

    ## [1] 85

    ## Warning: Unknown levels in `f`: 01

    ## [1] 86

    ## Warning: Unknown levels in `f`: 01

    ## [1] 87

    ## Warning: Unknown levels in `f`: 01

    ## [1] 88

    ## Warning: Unknown levels in `f`: 01

    ## [1] 89

    ## Warning: Unknown levels in `f`: 01

``` r
for(a in seq(90,102)) {
  print(a)
  emploi.raw <- bind_rows(emploi.raw, read_and_sum_90_02(paste0(dir,"empl",str_pad(a %% 100,2,pad="0"),"qi.dta"), annee = 1900+a))
  if(test) break
} 
```

    ## [1] 90
    ## [1] 91
    ## [1] 92
    ## [1] 93
    ## [1] 94
    ## [1] 95
    ## [1] 96
    ## [1] 97
    ## [1] 98
    ## [1] 99
    ## [1] 100
    ## [1] 101
    ## [1] 102

``` r
for(f in list.files(dir, pattern = "^indiv...\\.csv", ignore.case = TRUE)) {
  print(f)
  emploi.raw <- bind_rows(emploi.raw, read_and_sum_2003_(paste0(dir,f)))
  if(test) break
} 
```

    ## [1] "indiv031.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv032.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv033.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv034.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv041.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv042.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv043.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv044.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv051.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv052.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv053.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv054.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv061.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv062.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv063.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv064.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv071.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv072.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv073.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv074.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv081.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv082.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv083.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv084.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): Unknown levels in `f`: 2

    ## [1] "indiv091.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv092.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv093.csv"

    ## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec = dec, :
    ## caractère(s) 'nul' au milieu de l'entrée

    ## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec = dec, :
    ## Unknown levels in `f`: 2

    ## [1] "indiv094.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv101.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv102.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv103.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "indiv104.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV111.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV112.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV113.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV114.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV121.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): Unknown levels in `f`: 2

    ## [1] "INDIV122.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): Unknown levels in `f`: 2

    ## [1] "INDIV123.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): Unknown levels in `f`: 2

    ## [1] "INDIV124.csv"

    ## Warning in mask$eval_all_mutate(quo): NAs introduits lors de la conversion
    ## automatique

    ## Warning in mask$eval_all_mutate(quo): Unknown levels in `f`: 2

    ## [1] "INDIV131.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV132.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV133.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV134.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV141.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV142.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV143.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV144.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV151.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV152.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV153.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV154.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV161.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV162.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV163.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV164.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV171.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV172.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV173.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV174.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV181.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV182.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV183.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV184.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV191.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV192.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV193.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV194.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV201.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV202.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV203.csv"

    ## Warning: Unknown levels in `f`: 2

    ## [1] "INDIV204.csv"

    ## Warning: Unknown levels in `f`: 2

``` r
levels(emploi.raw$Sexe)
```

    ## [1] "H" "F"

``` r
levels(emploi.raw$Activite)
```

    ## [1] "Actif occupé"       "Etudiant"           "Chômeur ou inactif"

``` r
levels(emploi.raw$Diplome)
```

    ## [1] "Aucun"   "CAP-BEP" "DNB"     "Bac"     "Bac+2"   "Bac+3"   "Bac+5"  
    ## [8] "In"

``` r
levels(emploi.raw$Apprentissage)
```

    ## NULL

``` r
emploi.raw %>%
  select(-Population) %>%
  group_by(Annee, Trimestre) %>%
  summarise(
    across(Sexe:Apprentissage, n_distinct)
  )
```

    ## # A tibble: 107 × 7
    ## # Groups:   Annee [51]
    ##    Annee Trimestre  Sexe   Age Activite Diplome Apprentissage
    ##    <dbl>     <dbl> <int> <int>    <int>   <int>         <int>
    ##  1  1971        NA     2   100        3       8             1
    ##  2  1972        NA     2   100        3       8             1
    ##  3  1973        NA     2   100        3       3             1
    ##  4  1974        NA     2   100        3       8             1
    ##  5  1975        NA     2   100        4       8             3
    ##  6  1976        NA     2   100        4       8             3
    ##  7  1977        NA     2   100        4       8             3
    ##  8  1978        NA     2   100        4       8             3
    ##  9  1979        NA     2   100        4       8             3
    ## 10  1980        NA     2   100        4       8             3
    ## # … with 97 more rows

``` r
emploi.raw %>% 
  filter(Annee == 1982) %>% 
  pull(Apprentissage) %>%
  unique()
```

    ## [1] "Non apprentis" "Apprentis"     NA

## Reformatage

-   Moyennage sur 1 an
-   Calcul d’un salaire moyen

Les données issues de la variable SALRED se rapporte au salaire du
dernier mois (au moment de l’enquête) y compris les primes versées sur
ce mois. (Source : Dictionnaire des variables du fichier de données
individuelles de l’enquête Emploi Edition 2018). Dans le cas où
l’enquêté a cumulé plusieurs missions d’intérim au cours du mois, la
rémunération totale mensuelle à prendre est celle de la profession
principale. Il faut donc totaliser uniquement les rémunérations des
missions effectuées dans sa profession principale. Ainsi, il est
techniquement possible de faire une moyenne annuelle des salaires à
partir de la variable SALRED mais il faut avoir conscience qu’un biais
peut exister (la rémunération qui se rapporte au mois référé peut être
très différente de celle perçue les autres mois). La moyenne annuelle
est donc réalisée à partir de 4 mois de l’année seulement, ce qui peut
compremettre à la fiabilité des résultats si ces 4 mois ne sont pas
assez représentatifs de l’ensemble de l’année.

Autre raison : La variable qui donne de l’information sur le montant du
salaire est assez mal renseignée (ce n’est pas propre à cette enquête)
en raison du caractère assez tabou de cette question en France. Par
exemple, la variable SALRED du fichier indiv032 (enquête de 2003, 2ème
trimestre) contient 60 741 Non réponses pour 70 622 individus
interrogés. Ainsi les résultats produits à partir de la variable SALRED
seraient très peu fiables car non représentatifs de la population
totale. Il peut également y avoir un effet de sélection : les individus
qui renseignent le montant de leur rémunération peuvent avoir des
caractéristiques spécifiques/particulières (ex : âge, classe sociale,
niveau d’étude, etc…), ce qui empêcherait d’avoir une vision correcte et
globale de la population totale concernant le montant du salaire.

``` r
# Reformatage des variables
emploi <- emploi.raw %>%
  mutate(
    Activite = factor(ifelse(!is.na(Apprentissage) & Apprentissage == "Apprentis", "Apprentis", as.character(Activite)),
                      levels = c("Actif occupé", "Apprentis", "Etudiant", "Chômeur ou inactif") ),
    Diplome = factor(Diplome, levels = rev(c("Aucun", "DNB", "CAP-BEP", "Bac", "Bac+2", "Bac+3", "Bac+5")) )
  ) %>%
  
  mutate( AgeQ = as.numeric(as.character(cut(Age,seq(0,120,5),labels=seq(0,115,5),right=FALSE)) )) %>%
  group_by(Annee,Trimestre,Sexe,Age,AgeQ,Diplome,Activite) %>%
  summarise(Population = sum(Population)) %>%
  #mutate(Date = ifelse(is.na(Trimestre),Annee,Annee+(Trimestre-1)/4)) %>%
  group_by(Annee,Sexe,Age,AgeQ,Diplome,Activite) %>%
  summarise(Population = mean(Population)) %>%
  ungroup() 
```

``` r
emploi %>% 
  #filter(AgeQ == 20) %>%
  group_by(Annee) %>%
  summarise(pop = sum(Population))
```

    ## # A tibble: 51 × 2
    ##    Annee      pop
    ##    <dbl>    <dbl>
    ##  1  1971 49662920
    ##  2  1972 50091949
    ##  3  1973 50531639
    ##  4  1974 50867658
    ##  5  1975 51078604
    ##  6  1976 51222160
    ##  7  1977 51279355
    ##  8  1978 51481299
    ##  9  1979 51613781
    ## 10  1980 51825258
    ## # … with 41 more rows

``` r
save(emploi.raw,emploi,volumetrie,file="emploi.RData")
```
