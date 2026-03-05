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
  ns <- NS(id)
  tagList(
 
  )
}
    
#' basicDropdownApp Server Functions
#'
#' @noRd 
mod_basicDropdownApp_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_basicDropdownApp_ui("basicDropdownApp_1")
    
## To be copied in the server
# mod_basicDropdownApp_server("basicDropdownApp_1")
