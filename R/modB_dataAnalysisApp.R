# Modul B: Output eines Tabelle (je nach ausgewählten Datensatz im Menü von Modul A)

#' basicDropdownApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @import bslib
#' @import shiny
#' @importFrom DT dataTableOutput
modB_dataAnalysisApp_ui <- function(id) {
  ns <- NS(id)

  card(
    card_header("Grouped Data Table"),
    card_body(
      dataTableOutput(ns("data_table"))
    )
  )
}


#' dataAnalysis Server Functions
#' @param dataset_selection Reactive containing selected dataset
#' @param processed_data Reactive containing processed count data
#' @noRd
#' @import shiny
#' @importFrom DT renderDataTable datatable
modB_dataAnalysisApp_server <- function(id, dataset_selection, processed_data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Render data table
    output$data_table <- DT::renderDataTable({
      req(processed_data(), dataset_selection())

      data <- processed_data()
      dataset_name <- dataset_selection()

      DT::datatable(
        data,
        caption = paste("Dataset:", dataset_name)
      )
    })
  })
}


# # Dummy App for Module
# # Dummy App for Module B - Updated for shared reactives approach
# ui <- fluidPage(
#   titlePanel("Test: Table Module B"),
#   modB_dataAnalysisApp_ui("test")
# )
#
# server <- function(input, output, session) {
#
#
#
#   dataset_selection <- reactiveVal("iris")  #
#
#   # Shared processed data (reactive)
#   processed_data <- reactive({
#     req(dataset_selection())
#     dataset_name <- dataset_selection()
#
#     # Simulate the same processing as in app_server.R
#     raw_data <- switch(dataset_name,
#                        "iris" = iris,
#                        "cars" = ggplot2::mpg,
#                        "penguins" = palmerpenguins::penguins
#     )
#
#     library(dplyr)
#     switch(dataset_name,
#            "iris" = raw_data |> count(Species, name = "count"),
#            "cars" = raw_data |> count(manufacturer, name = "count"),
#            "penguins" = raw_data |> filter(!is.na(species)) |> count(species, name = "count")
#     )
#   })
#
#   dataset_selection("iris")      # Shows 3 species counts
#   # dataset_selection("cars")    # Shows ~15 manufacturer counts
#   # dataset_selection("penguins") # Shows 3 species counts
#
#   modB_dataAnalysisApp_server("test", dataset_selection, processed_data)
# }
#
# shinyApp(ui, server)

