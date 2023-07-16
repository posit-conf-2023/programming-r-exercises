library("tidyverse")
library("devtools")
library("testthat")

# https://twitter.com/ppaxisa/status/1574398423175921665
hex_plot <- function(df, x, y, z, bins = 20, fun = "mean") {
  df |>
    ggplot(aes(x = {{ x }}, y = {{ y }}, z = {{ z }})) +
    stat_summary_hex(
      aes(color = after_scale(fill)), # make border same color as fill
      bins = bins,
      fun = fun,
    )
}

diamonds |> hex_plot(carat, price, depth)

temp <- ggplot(mpg, aes(class, hwy)) +
  geom_boxplot(aes(fill = stage(class, after_scale = alpha(fill, 0.4))))

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
#' diamonds |> sorted_bars(clarity)
#'

withr::with_options(
  list(warnPartialMatchDollar = TRUE),
  test_that("mtcars has what we expect", {
    expect_is(mtcars$cy, "numeric")
  })
)

test_that("mtcars has what we expect", {
  expect_is(mtcars$cy, "numeric")
})


test_that("mtcars has what we expect", {
  withr::local_options(list(warnPartialMatchDollar = TRUE))
  expect_is(mtcars$cy, "numeric")
})

tempfile <- function(message) {
  file <- withr::local_tempfile(fileext = ".txt")

  saveRDS(message, file)
  print(fs::file_exists(file))

  file
}

sort(c("apple", "Banana", "candle"))

Sys.getlocale("LC_COLLATE")

withr::with_locale(
  new = c(LC_COLLATE = "C"),
  sort(c("apple", "Banana", "candle"))
)
