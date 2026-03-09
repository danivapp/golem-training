# Modul A: Gleiche Modul wie aus App 3, aber Tabellen werden in beiden Karten erst generiert,
# nachdem der Button aus Modul A erstmalig gedrückt wurde

#' interactiveDashboardApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
modA_interactiveDashboardApp_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h3("Dataset Selection"),
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

#' interactiveDashboardApp Server Function
#'
#' @noRd
modA_interactiveDashboardApp_server <- function(id){
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


# Simple test app
library(golem)

ui<- fluidPage(
  modA_interactiveDashboardApp_ui("test")
)
server <- function(input, output, session) {
  modA_interactiveDashboardApp_server("test")
}
shinyApp(ui, server)

