# ================================================================
# fixed_pipeline.R
# Version corrigée du tout premier script du README.
# Chaque erreur du script original est identifiée et corrigée.
# ================================================================

library(tidyverse)

# ----------------------------------------------------------------
# LE SCRIPT ORIGINAL (celui qui ne fonctionnait pas)
# ----------------------------------------------------------------
#   library(tidyverse)
#   mtcars |>
#     filter(cyl == 4) |>
#     ggplot(aes(x = wt, y = mpg)) |>
#     geom_point()

# ----------------------------------------------------------------
# ERREURS IDENTIFIÉES
# ----------------------------------------------------------------
#
# ERREUR 1 — Paquet "tidyverse" non installé
#   Message d'erreur : "there is no package called 'tidyverse'"
#   Cause            : l'environnement R ne contenait que les paquets de base.
#   Correctif        : install.packages("tidyverse") (fait avant l'exécution).
#
# ERREUR 2 — Mauvais opérateur pour ajouter une couche ggplot2  *** LA PLUS IMPORTANTE ***
#   Code fautif      : ... |> geom_point()
#   Message d'erreur : "`mapping` must be created by `aes()`.
#                       ✖ You've supplied a <ggplot2::ggplot> object.
#                       ℹ Did you use `%>%` or `|>` instead of `+`?"
#   Cause            : le pipe `|>` transmet le graphique comme PREMIER argument
#                      de geom_point(), or son premier argument est `mapping`.
#   Correctif        : les couches s'ajoutent avec `+`, pas avec `|>`.
#
# ERREUR 3 — La figure n'était ni affichée ni sauvegardée
#   Cause            : exécuté avec Rscript, le graphique n'est imprimé nulle part
#                      (et générait un fichier parasite Rplots.pdf).
#   Correctif        : print(p) pour l'afficher + ggsave() pour la sauvegarder.
#
# POINT D'ORGANISATION — le code était dans README.md au lieu d'un vrai script R.
#   Correctif        : création de scripts dédiés (plot.R, fixed_pipeline.R).
# ================================================================

# ----------------------------------------------------------------
# DÉMONSTRATION : reproduire l'ERREUR 2 pour bien la comprendre
# (capturée via tryCatch pour ne pas interrompre le script)
# ----------------------------------------------------------------
cat("\n--- Demonstration de l'erreur du pipe (|>) ---\n")
essai_errone <- tryCatch(
  {
    mtcars |>
      filter(cyl == 4) |>
      ggplot(aes(x = wt, y = mpg)) |>
      geom_point()
    "Aucune erreur ?! (surprenant)"
  },
  error = function(e) paste("Erreur capturee :", conditionMessage(e))
)
cat(essai_errone, "\n")

# ----------------------------------------------------------------
# VERSION CORRIGÉE
# - ERREUR 2 corrigée : `+ geom_point()` au lieu de `|> geom_point()`
# - ERREUR 3 corrigée : print() + ggsave() pour afficher et sauvegarder
# ----------------------------------------------------------------
cat("\n--- Version corrigee (operateur +) ---\n")
p <- mtcars |>
  filter(cyl == 4) |>
  ggplot(aes(x = wt, y = mpg)) +
  geom_point()

print(p)
ggsave("figure_mtcars.png", plot = p, width = 6, height = 4.5)
cat("Figure sauvegardee : figure_mtcars.png\n")
cat("Script corrige execute avec succes. \n")