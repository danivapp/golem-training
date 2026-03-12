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
#'
#' @noRd
modA_dataVisualizationApp_server <- function(id){
  moduleServer(id, function(input, output, session){

    # Create reactive output that shows selected dataset info
    output$selected_text <- renderText({
      generate_data_text(input$dataset_menu)
    })

    # return, as this will be used in module B of the app.
    return(reactive({
      input$dataset_menu
    }))
  })
}


# # Dummy App Module A
# library(golem)
#
# ui<- fluidPage(
#   modA_dataVisualizationApp_ui("test")
# )
# server <- function(input, output, session) {
#   modA_dataVisualizationApp_server("test")
# }
# shinyApp(ui, server)
