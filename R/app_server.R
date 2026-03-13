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
  selected_dataset_app2 <- modA_dataVisualizationApp_server("moduleA")
  modB_dataVisualizationApp_server("moduleB", selected_dataset_app2)

  # App 3: Data Analysis
  dataAnalysis_results <- modA_dataAnalysisApp_server("barChartApp")
  modB_dataAnalysisApp_server("dataAnalysisApp", dataAnalysis_results)

  # App 4: Dashboard Cards
  modA_dashboardCardsApp_server("dashboardA")
  modB_dashboardCardsApp_server("dashboardB")

  # App 5: Interactive Dashboard
  module_states_app5 <- modA_interactiveDashboardApp_server("app5_moduleA")
  modB_interactiveDashboardApp_server("app5_moduleB", module_states_app5)
}
