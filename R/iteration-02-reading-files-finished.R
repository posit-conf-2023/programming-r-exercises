library("tidyverse")
library("here")
library("fs")

paths_party <-
  # get the filepaths from the directory
  fs::dir_ls(here("data/gapminder_party")) |>
  # extract the year as names
  set_names(\(x) x |> basename() |> str_extract("^\\d+")) |>
  # convert to list
  as.list() |>
  identity()

# modify read-function to return NULL, rather than throw error
possibly_read_excel <- possibly(readxl::read_excel, otherwise = NULL)

data_party <-
  paths_party |>
  # read each file from excel
  map(possibly_read_excel) |>
  # keep only non-null elements
  # set list-names as column `year`
  # bind into single data-frame
  list_rbind(names_to = "year") |>
  # convert year to number
  mutate(year = parse_number(year)) |>
  identity()

# alternative to list_rbind():
list_rbind2 <- function(list, names_to) {
  list |>
    purrr::keep(\(x) !is.null(x)) |>
    purrr::imap(\(d, name) dplyr::mutate(d, "{names_to}" := name)) |>
    purrr::reduce(rbind)
}
