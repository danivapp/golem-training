# Modul A: Gleiche Modul wie aus App 1, wobei Dropdown-Menü die Optionen iris, cars und palmerpenguins::penguins hat.


#' dataVisualizationApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
modA_dataVisualizationApp_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("dataset_menu"),
      label = "Select a dataset:",
      choices = c( "iris","cars","penguins"),
      selected = "iris"),
    br(),
    h4("Selected Dataset:"),
    textOutput(ns("selected_text"))
  )
}

#' dataVisualizationApp Server Function
#'
#' @noRd
modA_dataVisualizationApp_server <- function(id){
  moduleServer(id, function(input, output, session){

    # Create reactive output that shows selected dataset info
    output$selected_text <- renderText({
      dataset_info <- list(
        "iris" = "Iris: Flower measurements (150 observations)",
        "cars" = "Cars: Speed vs stopping distance (50 observations)",
        "penguins" = "Penguins: Antarctic penguin data (344 observations)"
        )

      dataset_info[[input$dataset_menu]]
    })

    return(reactive({
      input$dataset_menu
    }))
  })
}


# # Simple test app
# library(golem)
#
# ui<- fluidPage(
#   modA_dataVisualizationApp_ui("test")
# )
# server <- function(input, output, session) {
#   modA_dataVisualizationApp_server("test")
# }
# shinyApp(ui, server)

