# Modul B: Output eines Tabelle (je nach ausgewählten Datensatz im Menü von Modul A)

#' basicDropdownApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
modB_dataAnalysisApp_ui <- function(id) {
  ns <- NS(id)

  card(
    card_header("Grouped Data Table"),
    card_body(
      DT::dataTableOutput(ns("data_table"))
    )
  )
}


#' dataAnalysis Server Functions
#'
#' @noRd
modB_dataAnalysisApp_server <- function(id, moduleA_data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Render data table
    output$data_table <- DT::renderDataTable({
      req(moduleA_data$processed_data())

      data <- moduleA_data$processed_data()
      dataset_name <- moduleA_data$dataset_selection()

      DT::datatable(
        data,
        caption = paste("Dataset:", dataset_name)
      )
    })
  })
}


# # Dummy App for Module
#
# ui <- fluidPage(
#   titlePanel("Test: Table Module B"),
#   modB_dataAnalysisApp_ui("test")
# )
#
# server <- function(input, output, session) {
#   # Simulate Module A output with correct structure for all datasets
#
#   # For IRIS (no processing - raw data)
#   simulated_moduleA_iris <- list(
#     dataset_selection = reactive("iris"),
#     processed_data = reactive({
#       library(dplyr)
#       iris |> count(Species, name = "count")
#     })
#   )
#
#   # For CARS (processed - manufacturer counts)
#   simulated_moduleA_cars <- list(
#     dataset_selection = reactive("cars"),
#     processed_data = reactive({
#       library(dplyr)
#       ggplot2::mpg |> count(manufacturer, name = "count")
#     })
#   )
#
#   # For PENGUINS (processed - filtered data, no missing species)
#   simulated_moduleA_penguins <- list(
#     dataset_selection = reactive("penguins"),
#     processed_data = reactive({
#       library(dplyr)
#       palmerpenguins::penguins |>
#         filter(!is.na(species)) |>
#         count(species, name = "count")
#     })
#   )
#
#   # Use one of them (change as needed for testing):
#   # modB_dataAnalysisApp_server("test", simulated_moduleA_cars)  # Test with cars
#   # modB_dataAnalysisApp_server("test", simulated_moduleA_iris)     # Test with iris
#   modB_dataAnalysisApp_server("test", simulated_moduleA_penguins) # Test with penguins
# }
#
# shinyApp(ui, server)

