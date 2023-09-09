library("tidyverse")

# Tidy evaluation

## Embracing
diamonds |>
  ggplot(aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

diamonds |>
  ggplot(aes(x = carat)) +
  geom_histogram(binwidth = 0.05)

# use {{embracing}} to set the x aesthetic
histogram <- function(df, var, binwidth = NULL) {
  df |>
    ggplot(aes()) +
    geom_histogram(binwidth = binwidth)
}

histogram(diamonds, carat, 0.1)

# try your new function out:
histogram(starwars, height)
histogram(mtcars, mpg)

# try specifying `theme_minimal()`
histogram(mtcars, mpg) +
  theme_minimal()

# try specifying `fill = "steelblue"`
histogram(starwars, height, fill = "steelblue")

## Using embracing for labels
temp <- function(varname, value) {
  rlang::englue("You chose varname: {{ varname }} and value: {value}")
}

temp(val, 0.4)

# Include the variable-name and binwidth in the title
histogram <- function(df, var, ..., binwidth = NULL) {
  df |>
    ggplot(aes(x = {{ var }})) +
    geom_histogram(binwidth = binwidth, ...) +
    labs(
      title = rlang::englue("")
    )
}

histogram(starwars, height, binwidth = 5)
histogram(starwars, height) # "extra credit"

## Using embracing to reorder data

sorted_bars <- function(df, var) {
  df |>
    mutate({{ var }} := {{ var }} |> fct_infreq() |> fct_rev()) |>
    ggplot(aes(y = {{ var }})) +
    geom_bar()
}

sorted_bars(diamonds, clarity)

## Extra

# If you like, use this as a prompt for chatGPT

#' Sorted bar chart
#'
#' Creates a bar chart where a categorical variable, `var`, is shown on the
#' y-axis, and count is shown on the x-axis. On the y-axis, categories are
#' shown in order (top-to-bottom) of decreasing count.
#'
#' This function uses tidy evaluation, so `var` is the bare name of a column in
#' the data frame `df`.
#'
#' @param df data frame
#' @param var bare variable-name from `df`
#'
#' @return ggplot2 object
#' @examples
#' # example code
#' sorted_bars(diamonds, clarity)
#'
