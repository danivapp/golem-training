#' Generate data text description
#' @param dataset_menu Character string with dataset name
#' @param use_mpg Logical, if TRUE uses ggplot2::mpg for cars, if FALSE uses mtcars
#' @return Character string with dataset description
#' @noRd
generate_data_text <- function(dataset_menu, use_mpg = TRUE) {

  dataset <- switch(dataset_menu,
                    "iris" = iris,
                    "cars" = if(use_mpg) ggplot2::mpg else mtcars,
                    "penguins" = palmerpenguins::penguins,
  )

  glue::glue(
    'The {tools::toTitleCase(dataset_menu)} dataset contains {nrow(dataset)} observations.'
  )
}


#' generate_food_text
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
generate_food_text <- function(food_name) {
  glue::glue(
    'Your are {food_name}.'
  )
}


#' Get dataset by name
#' @param dataset_name Character string: "iris", "cars", or "penguins"
#' @return data.frame
#' @noRd
get_dataset_by_name <- function(dataset_name) {
  switch(dataset_name,
         "iris" = iris,
         "cars" = ggplot2::mpg,
         "penguins" = palmerpenguins::penguins,
         stop("Unknown dataset: ", dataset_name))
}


#' Generate processed count data for datasets
#' @param dataset_name Character string
#' @param data data.frame
#' @return data.frame with count column
#' @noRd
#' @importFrom dplyr count filter
generate_processed_counts <- function(dataset_name, data) {
  library(dplyr)

  switch(dataset_name,
         "iris" = data |> count(Species, name = "count"),
         "cars" = data |> count(manufacturer, name = "count"),
         "penguins" = data |> filter(!is.na(species)) |> count(species, name = "count"),
         stop("Unknown dataset: ", dataset_name)
  )
}
