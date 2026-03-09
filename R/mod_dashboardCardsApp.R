# Modul A: Funktion my_card(header_name, ...):
# Diese Funktion erzeught eine bslib card, benutzt header_name als Title im Card Header.
# Alle weiteren Inputs werden von ... in den Card Body weitergeleitet.

# Modul A: Zeigt eine Card mit Titel Gesamtzufriedenheit, einer reactable()
# Tabelle mit 3 Zeilen und 2 Spalten (iwelche Fake-Daten) und einen
# Button unter der Tabelle (Button in diesem Beispiel ohne Funktion)

# Modul B: Zeigt eine Card mit Titel NPS und einer reactable()
# Tabelle mit 3 Zeilen und 2 Spalten (iwelche Fake-Daten)

# Modul A und B verwenden unterschiedliche Fake-Daten


# Helper Function: Create Bootstrap Card ------------------------------------

#' Create a Bootstrap Card with Header
#'
#' @description Creates a bslib card with a custom header and flexible body content
#' @param header_name Character string for the card title
#' @param ... Additional content to be placed in the card body
#' @return A bslib card object

my_card <- function(header_name, ...) {
  bslib::card(
    bslib::card_header(
      class = "bg-primary text-white",
      header_name
    ),
    bslib::card_body(
      ...
    )
  )
}

##############
## Module A
##############
#' dashboardCardsApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
modA_dashboardCardsApp_ui <- function(id) {
  ns <- NS(id)

  # Using my_card function here
  my_card(
    header_name = "Gesamtzufriedenheit",
    reactable::reactableOutput(ns("satisfaction_table")),
    br(),
    actionButton(ns("refresh_btn"), "Daten aktualisieren",
                 class = "btn-primary")
  )

}

#' dashboardCardsApp Server Function
#'
#' @noRd
modA_dashboardCardsApp_server <- function(id){
  moduleServer(id, function(input, output, session){

    # Fake satisfaction data
    satisfaction_data <- reactive({
      data.frame(
        Kategorie = c("Service", "Qualität", "Preis"),
        Bewertung = c(4.2, 4.5, 3.8)
      )
    })

    # Render table
    output$satisfaction_table <- reactable::renderReactable({
      reactable::reactable(
        satisfaction_data(),
        columns = list(
          Kategorie = reactable::colDef(name = "Kategorie", width = 120),
          Bewertung = reactable::colDef(name = "Bewertung", width = 120,
                                        format = reactable::colFormat(digits = 1))
        ),
        striped = TRUE,
        highlight = TRUE,
        borderless = TRUE,
        compact = TRUE
      )
    })

    # Button (no function as specified)
    observeEvent(input$refresh_btn, {
      showNotification("Button geklickt! (Keine Funktion)", type = "message")
    })

  })
}


# # # Simple test app
# library(golem)
# library(shiny)
# library(bslib)
# library(reactable)
#
# ui <- page_fluid(
#   theme = bslib::bs_theme(version = 5),  # Enable Bootstrap 5 for cards
#   titlePanel("Test: Module A - Gesamtzufriedenheit"),
#   br(),
#
#   # Test Module A in a container
#   div(
#     style = "max-width: 500px; margin: 0 auto;",
#     modA_dashboardCardsApp_ui("testA")
#   )
# )
#
# server <- function(input, output, session) {
#   modA_dashboardCardsApp_server("testA")
# }
#
# shinyApp(ui, server)



##############
## Module B
##############



