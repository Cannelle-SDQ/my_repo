# my_repo

Petit projet R : visualisation de `mtcars` avec **tidyverse** (dplyr + ggplot2).

## Exemple

Ce code garde les voitures à 4 cylindres et trace `mpg` en fonction de `wt` :

```r
library(tidyverse)

mtcars |>
  filter(cyl == 4) |>
  ggplot(aes(x = wt, y = mpg)) +
  geom_point()
```

## Prérequis

Installer les paquets nécessaires avant de lancer le script :

```r
install.packages("tidyverse")
```