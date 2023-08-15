library("tidyverse")
library("here")

by_clarity_csv <-
  diamonds |>
  # nest by clarity
  group_nest(clarity) |>
  # create column for filename
  mutate(filename = str_glue("clarity-{clarity}.csv")) |>
  identity()

walk2(
  by_clarity_csv$data,
  by_clarity_csv$filename,
  \(data, filename) write_csv(data, here("data", "clarity", filename))
)

carat_histogram <- function(df) {
  ggplot(df, aes(x = carat)) + geom_histogram(binwidth = 0.1)
}

by_clarity_plot <-
  diamonds |>
  # nest by clarity
  group_nest(clarity) |>
  # create columns for plot, filename
  mutate(
    filename = str_glue("clarity-{clarity}.png"),
    plot = map(data, carat_histogram),
  ) |>
  identity()

walk2(
  by_clarity_plot$plot,
  by_clarity_plot$filename,
  \(plot, filename)
    ggsave(here("data", "clarity", filename), plot, width = 6, height = 6)
)
