# Modul B: Output eines Tabelle (je nach ausgewählten Datensatz im Menü von Modul A)

#' basicDropdownApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
modB_dataAnalysis_ui <- function(id) {
  ns <- NS(id) # namespace System to prevent ID consflicts
  tagList()
}


#' dataAnalysis Server Functions
#'
#' @noRd
modB_dataAnalysis_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
  })
}
