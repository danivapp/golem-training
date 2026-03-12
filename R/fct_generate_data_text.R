#' generate_data_text
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
generate_data_text <- function(dataset_menu) {

  dataset <- switch(dataset_menu,
                    "iris" = iris,
                    "cars" = mtcars,
                    "penguins" = palmerpenguins::penguins,
  )

  glue::glue(
    'The {tools::toTitleCase(dataset_menu)} dataset contains {nrow(dataset)} observations.'
  )
}
