library("tidyverse")
library("here")

# write out files

# ?dplyr::group_nest
# ?stringr::str_glue

# from diamonds, create tibble with columns: clarity, data, filename
by_clarity_csv <-
  diamonds |>
  # nest by clarity
  # create column for filename
  identity()

# ?readr::write_csv

# using the data and filename, write out csv files
walk2(
  by_clarity_csv$data,
  by_clarity_csv$filename,
  \(data, filename) # write csv file to data/clarity directory
)

# write out plots

carat_histogram <- function(df) {
  ggplot(df, aes(x = carat)) + geom_histogram(binwidth = 0.1)
}

# from diamonds, create tibble with columns: clarity, data, plot, filename
by_clarity_plots <-
  diamonds |>
  # nest by clarity
  # create columns for filename, plot
  mutate(
    filename = str_glue(),
    plot = map()
  ) |>
  identity()

# ?ggplot2::ggsave

# using the data and filename, write out plots to png files
walk2(
  by_clarity_plot$filename,
  by_clarity_plot$plot,
  \(filename, plot) # write plot file to data/clarity directory
)
