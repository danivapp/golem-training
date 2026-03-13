# Gleiche App wie in 3, aber Tabellen werden in beiden Karten erst generiert,
# nachdem der Button aus Modul A erstmalig gedrückt wurde.

# generate new random data upon click on the button


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

  # Using my_card function here
  my_card(
    header_name = "Gesamtzufriedenheit",
    reactable::reactableOutput(ns("satisfaction_table")),
    br(),
    actionButton(ns("refresh_btn"), "Daten aktualisieren",
                 class = "btn-success btn-lg")
  )

}

#' interactiveDashboardApp Server Function
#'
#' @noRd
modA_interactiveDashboardApp_server <- function(id){
  moduleServer(id, function(input, output, session){

    # Track button clicks
    button_clicked <- reactiveVal(FALSE)
    # Track button press count for new data generation
    refresh_count <- reactiveVal(0)

    # Fake satisfaction data
    satisfaction_data <- reactive({
      set.seed(as.numeric(Sys.time()) + refresh_count())
      data.frame(
        Kategorie = c("Service", "Qualität", "Preis"),
        Bewertung = round(runif(3, min = 1.0, max = 5.0), 1)
      )
    })

    # Render table
    output$satisfaction_table <- reactable::renderReactable({
      req(button_clicked())

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

    # Button observer - now with functionality!
    observeEvent(input$refresh_btn, {
      button_clicked(TRUE)
      refresh_count(refresh_count() + 1)  # Increment for new data
      showNotification("Tables generated with fresh random data!",
                       type = "message", duration = 3)
    })

    # Return button state and refresh count for Module B
    return(list(
      button_clicked = button_clicked,
      refresh_count = refresh_count
    ))

  })
}


# ## Test Module A independently
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
#     modA_interactiveDashboardApp_ui("testA")
#   )
# )
#
# server <- function(input, output, session) {
#   modA_interactiveDashboardApp_server("testA")
# }
#
# shinyApp(ui, server)



##############
## Module B
##############

#' Module B: NPS UI Function
modB_interactiveDashboardApp_ui <- function(id) {
  ns <- NS(id)

  # Using my_card function here too
  my_card(
    header_name = "NPS",
    uiOutput(ns("content"))  # Single dynamic content area
  )
}

#' Module B: NPS Server Function
modB_interactiveDashboardApp_server <- function(id, module_states) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    # # DEBUG: Check what module_states contains
    # observe({
    #   cat("=== MODULE B DEBUG ===\n")
    #   cat("Button clicked:", module_states$button_clicked(), "\n")
    #   cat("Refresh count:", module_states$refresh_count(), "\n")
    # })

    # Different fake NPS data
    nps_data <- reactive({
      # This makes it reactive to refresh_count changes from Module A
      module_states$refresh_count()

      # Generate new random percentages that sum to 100
      set.seed(as.numeric(Sys.time()) + module_states$refresh_count() + 42)

      promoters <- sample(40:75, 1)
      detractors <- sample(5:25, 1)
      passives <- 100 - promoters - detractors

      data.frame(
        Segment = c("Promoters", "Passives", "Detractors"),
        Anteil = c(promoters, passives, detractors)
      )
    })

    # Simple conditional rendering - no runjs needed
    output$content <- renderUI({
      if(module_states$button_clicked()) {
        # Show table
        reactable::reactableOutput(ns("nps_table"))
      } else {
        # Show waiting message
        div(
          style = "text-align: center; padding: 50px; color: #666;"
        )
      }
    })

    # Render table
    output$nps_table <- reactable::renderReactable({

      # Wait for button
      req(module_states$button_clicked())

      reactable::reactable(
        nps_data(),
        columns = list(
          Segment = reactable::colDef(name = "Segment", width = 120),
          Anteil = reactable::colDef(name = "Anteil (%)", width = 120,
                                     format = reactable::colFormat(suffix = "%"))
        ),
        striped = TRUE,
        highlight = TRUE,
        borderless = TRUE,
        compact = TRUE
      )
    })
  })
}

# # Test Module B independently
#
# library(shinyjs)
#
# ui <- page_fluid(
#   theme = bslib::bs_theme(version = 5),  # Enable Bootstrap 5 for cards
#   titlePanel("Test: Module B - NPS"),
#   br(),
#
#   # Test Module B in a container
#   div(
#     style = "max-width: 500px; margin: 0 auto;",
#     modB_interactiveDashboardApp_ui("testB")
#   )
# )
#
# server <- function(input, output, session) {
#
#   # SIMULATE module_states for testing
#   simulated_states <- list(
#     button_clicked = reactiveVal(TRUE),  # Simulate button was clicked
#     refresh_count = reactiveVal(1)
#   )
#
#   modB_interactiveDashboardApp_server("testB", simulated_states)
# }
#
# shinyApp(ui, server)

