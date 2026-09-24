# broken_pipeline.R
# Reproduction exacte du tout premier script (celui qui ne fonctionnait pas).
# Ce script échoue volontairement : il sert de témoin pour la correction.

library(tidyverse)

mtcars |>
  filter(cyl == 4) |>
  ggplot(aes(x = wt, y = mpg)) |>
  geom_point()