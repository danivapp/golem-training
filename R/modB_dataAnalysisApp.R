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
  ns <- NS(id) # namespace System to prevent ID consflicts
  tagList(
    h3("Data Table"),
    DT::dataTableOutput(ns("data_table"))
  )
}


#' dataAnalysis Server Functions
#'
#' @noRd
modB_dataAnalysisApp_server <- function(id, selected_dataset){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Get current dataset based on Module A selection
    current_data <- reactive({
      req(selected_dataset())

      switch(selected_dataset(),
             "iris" = iris,
             "cars" = ggplot2::mpg,
             "penguins" = palmerpenguins::penguins
      )
    })

    # Render data table
    output$data_table <- DT::renderDataTable({
      req(current_data())

      DT::datatable(
        current_data(),
        options = list(
          pageLength = 15,
          scrollX = TRUE,
          scrollY = "400px",
          searching = TRUE,
          ordering = TRUE
        ),
        caption = paste("Dataset:", selected_dataset()),
        filter = 'top'  # Add column filters
      )
    })

  })
}


# # # Test Module B independently
# library(golem)
# library(shiny)
# library(DT)
#
#
# ui <- fluidPage(
#   titlePanel("Test: Table Module B"),
#   modB_dataAnalysisApp_ui("test")
# )
#
# server <- function(input, output, session) {
#   # Simulate Module A output
#   simulated_selection <- reactive("cars")
#   modB_dataAnalysisApp_server("test", simulated_selection)
# }
#
# shinyApp(ui, server)

