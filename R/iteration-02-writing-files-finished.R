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

carat_histogram <- function(df) {
  ggplot(df, aes(x = carat)) + geom_histogram(binwidth = 0.1)
}

by_clarity_plots <-
  diamonds |>
  # nest by clarity
  group_nest(clarity) |>
  # create plot, filename
  mutate(
    plot = map(data, carat_histogram),
    filename = str_glue("clarity-{clarity}.png")
  ) |>
  identity()

walk2(
  by_clarity_plots$plot,
  by_clarity_plots$filename,
  \(plot, filename)
    ggsave(here("data", "clarity", filename), plot, width = 6, height = 6)
)
