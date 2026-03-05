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
  ns <- NS(id) # namespace System to prevent ID consflicts
  tagList(
    selectInput(
      inputId = ns("dropdown_menu"),
      label = "Choose wisely",
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
mod_basicDropdownApp_server <- function(id){
  moduleServer(id, function(input, output, session){

    # Create reactive output that shows the selected dropdown value
    output$selected_text <- renderText({
      if(is.null(input$dropdown_menu)) {
        "Please select an option"
      } else {
        paste("You are:", input$dropdown_menu)
      }
    })

  })
}

## To be copied in the UI
# mod_basicDropdownApp_ui("basicDropdownApp_1")

## To be copied in the server
# mod_basicDropdownApp_server("basicDropdownApp_1")
