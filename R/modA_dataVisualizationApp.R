# Modul A: Gleiche Modul wie aus App 1, wobei Dropdown-Menü die Optionen iris, cars und palmerpenguins::penguins hat.


#' dataVisualizationApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList div selectInput textOutput h5
modA_dataVisualizationApp_ui <- function(id) {
  ns <- NS(id)
  div(
    class = "container-fluid",
    div(
      class= "row mb-3",
      selectInput(
        ns("dataset_menu"),
        "Select a dataset:",
        choices = c( "iris","cars","penguins"),
        selected = "iris")
    ),
    div(
      class = "col-12",
      h5("Selection Info:"),
      textOutput(ns("selected_text"))
    )
  )
}

#' dataVisualizationApp Server Function
#' @param dataset_selection ReactiveVal containing selected dataset
#' @param current_data Reactive containing raw dataset
#' @noRd
#' @importFrom shiny moduleServer observe bindEvent renderText req
modA_dataVisualizationApp_server <- function(id, dataset_selection, current_data){
  moduleServer(id, function(input, output, session){

    observe({
      dataset_selection(input$dataset_menu)
    }) |> bindEvent(input$dataset_menu)

    # Create reactive output that shows selected dataset info
    output$selected_text <- renderText({
      req(dataset_selection())
      generate_data_text(dataset_selection(), use_mpg = FALSE)
    })
  })
}


# # Dummy App Module A
# library(golem)
#
# ui<- bslib::page_fluid(
#   modA_dataVisualizationApp_ui("test")
# )
#
# server <- function(input, output, session) {
#   modA_dataVisualizationApp_server("test")
# }
#
# shinyApp(ui, server)
