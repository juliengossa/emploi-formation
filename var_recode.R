# sexe

var_recode_sexe = c(
  "H" = "1",
  "F" = "2"
)

# Activite

var_recode_CSE = c(
  NULL = "",
  "Actif occupé" = "00",
  "Actif occupé" = "10",
  "Actif occupé" = "21",
  "Actif occupé" = "22",
  "Actif occupé" = "23",
  "Actif occupé" = "26",
  "Actif occupé" = "27",
  "Actif occupé" = "30",
  "Actif occupé" = "32",
  "Actif occupé" = "33",
  "Actif occupé" = "34",
  "Actif occupé" = "41",
  "Actif occupé" = "42",
  "Actif occupé" = "43",
  "Actif occupé" = "44",
  "Actif occupé" = "51",
  "Actif occupé" = "53",
  "Actif occupé" = "60",
  "Actif occupé" = "61",
  "Actif occupé" = "63",
  "Actif occupé" = "65",
  "Actif occupé" = "66",
  "Actif occupé" = "67",
  "Actif occupé" = "68",
  "Actif occupé" = "70",
  "Actif occupé" = "71",
  "Actif occupé" = "72",
  "Actif occupé" = "80",
  "Actif occupé" = "81",
  "Actif occupé" = "82",
  "Etudiant" = "91",
  "Actif occupé" = "92",
  "Chômeur ou inactif" = "93",
  "Chômeur ou inactif" = "94",
  "Chômeur ou inactif" = "95",
  "Chômeur ou inactif" = "96",
  "Chômeur ou inactif" = "97",
  "Chômeur ou inactif" = "98",
  "Chômeur ou inactif" = "99"
)

var_recode_FI = c(
  NULL = "",
  "Actif occupé" = "1",
  "Chômeur ou inactif" = "2",
  "Chômeur ou inactif" = "3",
  "Etudiant" = "4",
  "Actif occupé" = "5",
  "Chômeur ou inactif" = "6",
  "Chômeur ou inactif" = "7",
  "Chômeur ou inactif" = "8"
)

var_recode_ACT17 = c(
  NULL = "",
  "Actif occupé" = "1",
  "Actif occupé" = "2",
  "Chômeur ou inactif" = "3",
  "Chômeur ou inactif" = "4",
  "Etudiant" = "5",
  "Chômeur ou inactif" = "6",
  "Chômeur ou inactif" = "7"
)

var_recode_ACT7 = c(
  NULL = "",
  "Actif occupé" = "1",
  "Actif occupé" = "2",
  "Chômeur ou inactif" = "3",
  "Chômeur ou inactif" = "4",
  "Etudiant" = "5",
  "Chômeur ou inactif" = "6",
  "Chômeur ou inactif" = "7"
)


var_recode_ACTUE6 = c(
  NULL = "",
  "Actif occupé" = "1",
  "Actif occupé" = "2",
  "Chômeur ou inactif" = "3",
  "Chômeur ou inactif" = "4",
  "Etudiant" = "5",
  "Chômeur ou inactif" = "6"
)


# Diplome

var_recode_DIP_1975 = c(
  NULL = "",
  NULL = "**",
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

var_recode_DIPL = c(
  NULL = "",
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



var_recode_DIP_2003 = c(
  NULL = "",
  "Aucun" = "70",
  "Aucun" = "71",
  "DNB" = "60",
  "CAP-BEP" = "50",
  "CAP-BEP" = "44",
  "Bac" = "43",
  "Bac" = "42",
  "Bac" = "41",
  "Bac+2" = "33",
  "Bac+2" = "32",
  "Bac+2" = "31",
  "Bac+2" = "30",
  "Bac+5" = "22",
  "Bac+3" = "21",
  "Bac+5" = "12",
  "Bac+5" = "10"
)



# Salaire

var_recode_SALREDTR = c(
  NULL = "",
  "[0,500)" = "A",
  "[500,1000)" = "B",
  "[1000,1250)" = "C",
  "[1250,1500)" = "D",
  "[1500,2000)" = "E",
  "[2000,2500)" = "F",
  "[2500,3000)" = "G",
  "[3000,5000)" = "H",
  "[5000,8000)" = "I",
  "[8000,∞]" = "J"
)


# Apprentissage

var_recode_ST = c(
  NULL = "",
  "Non apprentis" = "0",
  "Non apprentis" = "1",
  "Non apprentis" = "2",
  "Non apprentis" = "3",
  "Non apprentis" = "4",
  "Apprentis" = "5",
  "Non apprentis" = "6",
  "Non apprentis" = "7",
  "Non apprentis" = "8"
) 

var_recode_STATUT = c(
  NULL = "",
  "Non apprentis" = "01",
  "Non apprentis" = "02",
  "Non apprentis" = "03",
  "Non apprentis" = "04",
  "Non apprentis" = "11",
  "Non apprentis" = "12",
  "Non apprentis" = "13",
  "Non apprentis" = "21",
  "Apprentis" = "22",
  "Non apprentis" = "23",
  "Non apprentis" = "24",
  "Non apprentis" = "25",
  "Non apprentis" = "26",
  "Non apprentis" = "27",
  "Non apprentis" = "28",
  "Non apprentis" = "29",
  "Non apprentis" = "31",
  "Non apprentis" = "32",
  "Non apprentis" = "33",
  "Non apprentis" = "34",
  "Non apprentis" = "35",
  "Non apprentis" = "36",
  "Non apprentis" = "37"
)

var_recode_STATUT90 = c(
  NULL = "",
  "Non apprentis" = "11",
  "Non apprentis" = "12",
  "Non apprentis" = "13",
  "Non apprentis" = "21",
  "Apprentis" = "22",
  "Non apprentis" = "23",
  "Non apprentis" = "24",
  "Non apprentis" = "30",
  "Non apprentis" = "41",
  "Non apprentis" = "42"
)


var_recode_STATUTR = c(
  NULL = "",
  "Non apprentis" = "1",
  "Non apprentis" = "2",
  "Apprentis" = "3",
  "Non apprentis" = "4",
  "Non apprentis" = "5",
  "Non apprentis" = "9"
)

