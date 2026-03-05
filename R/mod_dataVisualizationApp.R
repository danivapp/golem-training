#' dataVisualizationApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_dataVisualizationApp_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("dropdown_menu"),
      label = "Choose wisely",
      choices = list(
        "Option 1" = "option1",
        "Option 2" = "option2",
        "Option 3" = "option3",
        "Option 4" = "option4"
      )
    )
  )
}

#' dataVisualizationApp Server Functions
#'
#' @noRd
mod_dataVisualizationApp_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_dataVisualizationApp_ui("dataVisualizationApp_1")

## To be copied in the server
# mod_dataVisualizationApp_server("dataVisualizationApp_1")
