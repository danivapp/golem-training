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
