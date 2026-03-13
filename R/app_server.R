#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # # Load dependencies
  # load_app_dependencies()

  # App 1: Basic dropdown
  mod_basicDropdownApp_server("basicDropdownApp_1")

  # App 2: Data visualization modules
  dataset_selection_app2 <- reactiveVal("iris")

  current_data_app2 <- reactive({
    req(dataset_selection_app2())
    switch(dataset_selection_app2(),
           "iris" = iris,
           "cars" = cars,
           "penguins" = palmerpenguins::penguins)
  })

  modA_dataVisualizationApp_server("moduleA", dataset_selection_app2, current_data_app2)
  modB_dataVisualizationApp_server("moduleB", dataset_selection_app2, current_data_app2)

  # App 3: Data Analysis
  dataset_selection <- reactiveVal("iris")

  processed_data <- reactive({
    req(dataset_selection())
    dataset_name <- dataset_selection()
    raw_data <- get_dataset_by_name(dataset_name)
    generate_processed_counts(dataset_name, raw_data)
  })

  modA_dataAnalysisApp_server("barChartApp", dataset_selection, processed_data)
  modB_dataAnalysisApp_server("dataAnalysisApp", dataset_selection, processed_data)

  # App 4: Dashboard Cards
  modA_dashboardCardsApp_server("dashboardA")
  modB_dashboardCardsApp_server("dashboardB")

  # App 5: Interactive Dashboard
  module_states_app5 <- modA_interactiveDashboardApp_server("app5_moduleA")
  modB_interactiveDashboardApp_server("app5_moduleB", module_states_app5)
}
