library("tidyverse")
library("here")
library("fs")

data1952 <- readxl::read_excel(here("data/gapminder/1952.xlsx"))
data1957 <- readxl::read_excel(here("data/gapminder/1957.xlsx"))
data1962 <- readxl::read_excel(here("data/gapminder/1952.xlsx"))
data1967 <- readxl::read_excel(here("data/gapminder/1967.xlsx"))

data_manual <- bind_rows(data1952, data1957, data1962, data1967)

# What problems do you see so far?
# (I see two "real" problems, one philosophical problem)

paths <-
  # get the filepaths from the directory
  fs::dir_ls(here("data/gapminder")) |>
  # extract the year as names
  # convert to list
  identity()


data <-
  paths |>
  # read each file from excel, into data frame
  # keep only non-null elements
  # set list-names as column `year`
  # bind into single data-frame
  # convert year to number
  identity()

paths_party <-
  # get the filepaths from the directory
  fs::dir_ls(here("data/gapminder_party")) |>
  # extract the year as names
  # convert to list
  identity()

# modify read-function to return NULL, rather than throw error

data_party <-
  paths_party |>
  # read each file from excel, into data frame
  # keep only non-null elements
  # set list-names as column `year`
  # bind into single data-frame
  # convert year to number
  identity()

