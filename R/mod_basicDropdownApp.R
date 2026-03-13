#' basicDropdownApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_basicDropdownApp_ui <- function(id) {
  ns <- NS(id) # namespace System to prevent ID conflicts
  tagList(
    selectInput(
      ns("dropdown_menu"),
      "Choose wisely",
      choices = list(
        "Chilli Sin Carne" = "vegeterian",
        "Veggie Risotto" = "vegan",
        "Steak" = "carnivor",
        "Ice Cubes" = "on diet"
      )
    ),
    h3("You are:"),
    textOutput(ns("selected_text"))
  )
}


#' basicDropdownApp Server Functions
#'
#' @noRd
#' @import shiny
mod_basicDropdownApp_server <- function(id){
  moduleServer(id, function(input, output, session){

    output$selected_text <- renderText({
      generate_food_text(input$dropdown_menu)
    })
  })
}

## To be copied in the UI
# mod_basicDropdownApp_ui("basicDropdownApp_1")

## To be copied in the server
# mod_basicDropdownApp_server("basicDropdownApp_1")


# # Dummy App
# library(shiny)
#
# ui <- bslib::page_fluid(
#   mod_basicDropdownApp_ui("basicDropdownApp_1")
# )
#
# server <- function(input, output, session){
#   mod_basicDropdownApp_server("basicDropdownApp_1")
# }
#
# shinyApp(ui, server)






