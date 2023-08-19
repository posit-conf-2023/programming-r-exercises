library("tidyverse")

# Tidy evaluation

## Embracing

# use {{embracing}} to set the x aesthetic
histogram <- function(df, var, binwidth = NULL) {
  df |>
    ggplot(aes()) +
    geom_histogram(binwidth = binwidth)
}

# try your new function out:
histogram(starwars, height)
histogram(mtcars, mpg)

# try specifying `theme_minimal()`
histogram(mtcars, mpg) +
  theme_minimal()

# try specifying `fill = "steelblue"`
histogram(starwars, height, fill = "steelblue")

## Using embracing for labels

# Include the variable-name and binwidth in the title
histogram <- function(df, var, ..., binwidth = NULL) {
  df |>
    ggplot(aes(x = {{ var }})) +
    geom_histogram(binwidth = binwidth, ...) +
    labs(
      title = rlang::englue("")
    )
}

histogram(starwars, height, binwidth = 5, fill = "steelblue")
histogram(starwars, height, fill = "steelblue")

## Using embracing to reorder data

sorted_bars <- function(df, var) {
  df |>
    mutate({{ var }} := {{ var }} |> fct_infreq() |> fct_rev()) |>
    ggplot(aes(y = {{ var }})) +
    geom_bar()
}

diamonds |> sorted_bars(clarity)
