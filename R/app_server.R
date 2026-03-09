#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # Load dependencies
  load_app_dependencies()

  # App 1: Basic dropdown
  mod_basicDropdownApp_server("basicDropdownApp_1")

  # App 2: Data visualization modules
  selected_dataset <- modA_dataVisualizationApp_server("moduleA")
  modB_dataVisualizationApp_server("moduleB", selected_dataset)

  # App 3: Data Analysis
  selected_dataset_app3 <- modA_dataAnalysisApp_server("barChartApp")
  modB_dataAnalysisApp_server("dataAnalysisApp", selected_dataset_app3)

  # App 4: Dashboard Cards

  # App 5: Interactive Dashboard

}
