library("tidyverse")

## Your turn: which of these functions are pure, which have or use side effects?
x <- prod(1, 2, 3)

x <- print("Hello")

x <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()

x <- sort(c("apple", "Banana", "candle"))


## Our turn:
# look at `collate` setting in first section
devtools::session_info()

# this is the locale setting
Sys.getlocale("LC_COLLATE")

sort(c("apple", "Banana", "candle"))

# set only within expression
withr::with_locale(
  # set new locale to "C"
  # sort vector
)

Sys.getlocale("LC_COLLATE")

# set only within scope
c_sort <- function(...) {
  # use withr::local_locale() to set only within function block
}

c_sort(c("apple", "Banana", "candle"))

Sys.getlocale("LC_COLLATE")

## Your turn: modify testthat options
library("testthat")

getOption("warnPartialMatchDollar")

test_that("mtcars has expected columns", {
  # use withr::local_options() to set `warnPartialMatchDollar = TRUE`
  expect_type(mtcars$cy, "double")
})

mtcars$cy

## Extra

tempfile <- function(message) {
  file <- withr::local_tempfile(fileext = ".txt")

  saveRDS(message, file)
  print(fs::file_exists(file))

  file
}

file <- tempfile("Hello")
fs::file_exists(file)



