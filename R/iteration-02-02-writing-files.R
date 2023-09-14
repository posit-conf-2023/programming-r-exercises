library("conflicted")
library("palmerpenguins")
library("tidyverse")
library("here")

## Write out files

# ?dplyr::group_nest(), ?stringr::str_glue()
# from diamonds, create tibble with columns: clarity, data, filename
by_clarity_csv <-
  diamonds |>
  # nest by clarity
  # create column for filename
  print()

# ?readr::write_csv()
# using the data and filename, write out csv files
walk2(
  by_clarity_csv$data,
  by_clarity_csv$filename,
  \(data, filename) NULL # replace with actual code
)

## Write out plots

# remember me?
histogram <- function(df, var, ..., binwidth = NULL) {
  df |>
    ggplot(aes(x = {{var}})) +
    geom_histogram(binwidth = binwidth, ...)
}

# from diamonds, create tibble with columns: clarity, data, plot, filename
by_clarity_plots <-
  diamonds |>
  # nest by clarity
  group_nest(clarity) |>
  # create columns for filename, plot
  mutate(
    filename = str_glue("clarity-{clarity}.png")#,
    #plot = map()
  ) |>
  print()

# ?ggplot2::ggsave
ggsave_local <- function(filename, plot) {

}

# using the data and filename, write out plots to png files
walk2(
  by_clarity_plot$filename,
  by_clarity_plot$plot,
  # write plot file to data/clarity directory
  ggsave_local
)

## Functions as arguments

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point() +
  scale_color_discrete(labels = tolower) # tolower is a function

## dplyr using purrr (if time permits)

dpurrr_filter <- function(df, predicate) {
  df |>
    as.list() |>
    purrr::list_transpose(simplify = FALSE) |>
    purrr::keep(predicate) |>
    purrr::list_transpose() |>
    as.data.frame()
}

dpurrr_filter(mtcars, \(d) d$gear == 3) |> head()

dpurrr_mutate <- function(df, mapper) {
  df |>
    as.list() |>
    purrr::list_transpose(simplify = FALSE) |>
    purrr::map(\(d) c(d, mapper(d))) |>
    purrr::list_transpose() |>
    as.data.frame()
}

mtcars |>
  dpurrr_mutate(\(d) list(wt_kg = d$wt * 1000 / 2.2)) |>
  head()

dpurrr_summarise <- function(df, reducer, .init) {
  df |>
    as.list() |>
    purrr::list_transpose(simplify = FALSE) |>
    purrr::reduce(reducer, .init = .init) |>
    as.data.frame()
}

mtcars |>
  dpurrr_summarise(
    reducer = \(acc, val) list(
      wt_min = min(acc$wt_min, val$wt),
      wt_max = max(acc$wt_max, val$wt)
    ),
    .init = list(wt_min = Inf, wt_max = -Inf)
  )

## With grouping

ireduce <- function(x, reducer, .init) {
  purrr::reduce2(x, names(x), reducer, .init = .init)
}

summariser <- purrr::partial(
  dpurrr_summarise,
  reducer = \(acc, val) list(
    wt_min = min(acc$wt_min, val$wt),
    wt_max = max(acc$wt_max, val$wt)
  ),
  .init = list(wt_min = Inf, wt_max = -Inf)
)

mtcars |>
  split(mtcars$gear) |>
  purrr::map(summariser) |>
  ireduce(
    reducer = \(acc, x, y) rbind(acc, c(list(gear = y), x)),
    .init = data.frame()
  )


