library("tidyverse")
library("here")

by_clarity_files <-
  diamonds |>
  # nest by clarity
  group_nest(clarity) |>
  # create file name
  mutate(filename = str_glue("clarity-{clarity}.csv")) |>
  identity()

walk2(
  by_clarity_files$data,
  by_clarity_files$filename,
  \(data, filename) write_csv(data, here("data", "clarity", filename))
)
