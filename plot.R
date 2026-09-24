# Script : visualisation de mtcars (tidyverse)
# Données : voitures à 4 cylindres, mpg en fonction de wt

library(tidyverse)

p <- mtcars |>
  filter(cyl == 4) |>
  ggplot(aes(x = wt, y = mpg)) +
  geom_point()

# Affichage et sauvegarde de la figure
print(p)
ggsave("figure_mtcars.png", plot = p, width = 6, height = 4.5)