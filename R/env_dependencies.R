#' Simple Dependencies Check
#'
#' @description Basic package loading for training app
#' @noRd

#' Load required packages
load_app_dependencies <- function() {

  # Required packages
  packages <- c("ggplot2", "palmerpenguins", "shiny", "golem", "ggplot2", "bslib", "reactable", "glue")

  # Check and load each package
  for(pkg in packages) {
    if(!require(pkg, character.only = TRUE, quietly = TRUE)) {
      stop("Please install package: ", pkg,
           "\nRun: install.packages('", pkg, "')")
    }
  }

  cat("✅ Packages loaded!\n")
}
