library("tidyverse")
library("conflicted")

conflicts_prefer(dplyr::filter)

mtcars |> filter(cyl == 6)
