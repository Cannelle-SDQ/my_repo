# my_repo

Projet R de visualisation : à partir de `mtcars`, on garde les voitures à
4 cylindres et on trace **`mpg` (consommation) en fonction de `wt` (poids)** avec
**tidyverse** (dplyr + ggplot2).

## Scripts du dépôt

| Fichier                | Rôle                                                                 |
|------------------------|----------------------------------------------------------------------|
| `broken_pipeline.R`    | Reproduction exacte du script d'origine : **échoue volontairement** (témoin de l'erreur). |
| `fixed_pipeline.R`     | Version corrigée : identifie chaque erreur, démontre le bug principal, puis exécute la pipeline fonctionnelle. |
| `plot.R`               | Version simple et épurée de la pipeline corrigée.                    |

## Exemple

```r
mtcars |>
  filter(cyl == 4) |>
  ggplot(aes(x = wt, y = mpg)) +
  geom_point()
```

## Changelog — bugs corrigés par rapport au script d'origine

- **Paquet `tidyverse` non installé** — `library(tidyverse)` échouait avec
  *« there is no package called 'tidyverse' »*. → corrigé par
  `install.packages("tidyverse")` (fait une fois avant l'exécution).
- **Mauvais opérateur pour ajouter une couche ggplot2 (bug principal)** —
  `|> geom_point()` transmettait le graphique au premier argument de
  `geom_point()` (qui est `mapping`), d'où l'erreur *« `mapping` must be
  created by `aes()` ... Did you use `%>%` or `|>` instead of `+`? »*.
  → corrigé en remplaçant `|>` par `+`.
- **Figure ni affichée ni sauvegardée** — exécuté via `Rscript`, le graphique
  n'apparaissait nulle part, et un fichier parasite `Rplots.pdf` était généré.
  → corrigé en ajoutant `print(p)` (affichage) et `ggsave()` (sauvegarde en
  `figure_mtcars.png`, 6 × 4,5 pouces).
- **Code cantonné au README** — le code d'origine n'était pas un script
  exécutable. → corrigé en le déplaçant dans des scripts dédiés
  (`broken_pipeline.R`, `fixed_pipeline.R`).

## Comment exécuter la pipeline corrigée

1. Installer `tidyverse` (une seule fois, si ce n'est pas déjà fait) :

   ```r
   install.packages("tidyverse")
   ```

2. Exécuter le script corrigé :

   ```bash
   Rscript fixed_pipeline.R
   ```

3. Résultat : la figure **`figure_mtcars.png`** est générée dans le répertoire
   du projet. Le script affiche aussi la démonstration de l'erreur d'origine
   (capturée par `tryCatch`) avant d'exécuter la version corrigée.

> 💡 Pour observer l'erreur d'origine : `Rscript broken_pipeline.R` se termine
> volontairement en erreur (exit 1) sur « `mapping` must be created by `aes()` »
> — c'est le comportement attendu de ce fichier témoin.