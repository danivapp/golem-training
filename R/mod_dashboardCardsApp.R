# Modul A: Funktion my_card(header_name, ...):
# Diese Funktion erzeught eine bslib card, benutzt header_name als Title im Card Header.
# Alle weiteren Inputs werden von ... in den Card Body weitergeleitet.

# Modul A: Zeigt eine Card mit Titel Gesamtzufriedenheit, einer reactable()
# Tabelle mit 3 Zeilen und 2 Spalten (iwelche Fake-Daten) und einen
# Button unter der Tabelle (Button in diesem Beispiel ohne Funktion)

# Modul B: Zeigt eine Card mit Titel NPS und einer reactable()
# Tabelle mit 3 Zeilen und 2 Spalten (iwelche Fake-Daten)

# Modul A und B verwenden unterschiedliche Fake-Daten

##############
## Module A
##############
#' dashboardCardsApp UI Function
#'
#' @description A shiny Module.
#' @param id,input,output,session Internal parameters for {shiny}.

#' @noRd
#' @import bslib
#' @import shiny
#' @importFrom reactable reactableOutput
modA_dashboardCardsApp_ui <- function(id) {
  ns <- NS(id)

  card(
    card_header(
      class = "bg-primary text-white",
      "Gesamtzufriedenheit"
    ),
    card_body(
      reactable::reactableOutput(ns("satisfaction_table"))
    )
  )
}

#' dashboardCardsApp Server Function
#' @noRd
#' @param shared_satisfaction_data Reactive containing satisfaction data
#' @import shiny
#' @import reactable
modA_dashboardCardsApp_server <- function(id, shared_satisfaction_data){
  moduleServer(id, function(input, output, session){

    # Render table
    output$satisfaction_table <- renderReactable({
      req(shared_satisfaction_data())

      reactable::reactable(
        shared_satisfaction_data(),
        columns = list(
          Kategorie = reactable::colDef(name = "Kategorie", width = 120),
          Bewertung = reactable::colDef(name = "Bewertung", width = 120,
                             format = colFormat(digits = 1))
        ),
        striped = TRUE,
        highlight = TRUE,
        borderless = TRUE,
        compact = TRUE
      )
    })
  })
}


# # dummy app - Module A
#
# ui <- page_fluid(
#   theme = bslib::bs_theme(version = 5),  # Enable Bootstrap 5 for cards
#   titlePanel("Test: Module A - Gesamtzufriedenheit"),
#
#   # Test Module A in a container
#   div(
#     style = "max-width: 500px; margin: 0 auto;",
#     modA_dashboardCardsApp_ui("testA")
#   )
# )
#
# server <- function(input, output, session) {
#   # Simulate shared satisfaction data
#   shared_satisfaction_data <- reactive({
#     data.frame(
#       Kategorie = c("Service", "Qualität", "Preis"),
#       Bewertung = c(4.2, 4.5, 3.8)
#     )
#   })
#
#   modA_dashboardCardsApp_server("testA", shared_satisfaction_data)
# }
#
# shinyApp(ui, server)



##############
## Module B
##############

#' Module B: NPS UI Function
#' @noRd
#' @import bslib
#' @import shiny
#' @importFrom reactable reactableOutput
modB_dashboardCardsApp_ui <- function(id) {
  ns <- NS(id)

  card(
    card_header(
      class = "bg-primary text-white",
      "NPS"
    ),
    card_body(
      reactable::reactableOutput(ns("nps_table"))
    )
  )
}

#' Module B: NPS Server Function
#' @param shared_nps_data Reactive containing NPS data
#' @noRd
#' @import shiny
#' @importFrom reactable renderReactable reactable colDef colFormat
modB_dashboardCardsApp_server <- function(id, shared_nps_data) {
  moduleServer(id, function(input, output, session) {

    # Render table using shared data
    output$nps_table <- renderReactable({
      req(shared_nps_data())

      reactable::reactable(
        shared_nps_data(),
        columns = list(
          Segment = reactable::colDef(name = "Segment", width = 120),
          Anteil = reactable::colDef(name = "Anteil (%)", width = 120,
                          format = colFormat(suffix = "%"))
        ),
        striped = TRUE,
        highlight = TRUE,
        borderless = TRUE,
        compact = TRUE
      )
    })
  })
}

# Dummy App - Module B
#
# ui <- page_fluid(
#   theme = bslib::bs_theme(version = 5),  # Enable Bootstrap 5 for cards
#   titlePanel("Test: Module B - NPS"),
#
#   # Test Module B in a container
#   div(
#     style = "max-width: 500px; margin: 0 auto;",
#     modB_dashboardCardsApp_ui("testB")
#   )
# )
#
# server <- function(input, output, session) {
#   # Simulate shared NPS data
#   shared_nps_data <- reactive({
#     data.frame(
#       Segment = c("Promoters", "Passives", "Detractors"),
#       Anteil = c(65, 25, 10)
#     )
#   })
#
#   modB_dashboardCardsApp_server("testB", shared_nps_data)
# }
#
# shinyApp(ui, server)
