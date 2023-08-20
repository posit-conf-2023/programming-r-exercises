library("tidyverse")

## Your turn: which of these functions are pure, which have or use side effects?
x <- prod(1, 2, 3) # pure

x <- print("Hello") # side effect

x <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() # pure

x <- sort(c("apple", "Banana", "candle")) # side effect


## Our turn:
# look at `collate` setting in first section
devtools::session_info()

# this is the locale setting
Sys.getlocale("LC_COLLATE")

sort(c("apple", "Banana", "candle"))

# set only within expression
withr::with_locale(
  new = list(LC_COLLATE = "C"),
  sort(c("apple", "Banana", "candle"))
)

Sys.getlocale("LC_COLLATE")

# set only within scope
c_sort <- function(...) {
  # set only within function block
  withr::local_locale(list(LC_COLLATE = "C"))

  sort(...)
}

c_sort(c("apple", "Banana", "candle"))

Sys.getlocale("LC_COLLATE")

## Your turn: modify testthat options
library("testthat")

getOption("warnPartialMatchDollar")

test_that("mtcars has expected columns", {
  # use withr::local_options() to set `warnPartialMatchDollar = TRUE`
  withr::local_options(list(warnPartialMatchDollar = TRUE))
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
