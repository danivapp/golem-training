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
modB_dataVisualizationApp_ui <- function(id) {
  ns <- NS(id)
  tagList(

  )
}

#' dataVisualizationApp Server Functions
#'
#' @noRd
modB_dataVisualizationApp_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_dataVisualizationApp_ui("dataVisualizationApp_1")

## To be copied in the server
# mod_dataVisualizationApp_server("dataVisualizationApp_1")
