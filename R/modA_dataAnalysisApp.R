# Modul A: Dropdown-Menü mit Optionen iris, ggplot2::mpg und palmerpenguins::penguins.
# Bei Auswahl des Datensatzes wir eine Balkendiagramm erzeugt, grouped by

#' dataAnalysis UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#'
#' @noRd
#' @import bslib
#' @import shiny
#' @import ggplot2
#'
#' @importFrom tools toTitleCase
#'
#' @export
#' @noRd
modA_dataAnalysisApp_ui <- function(id) {
  ns <- NS(id)

  # Simple layout - let the main app handle the positioning
  tagList(
    card(
      card_header("Dataset Selection"),
      card_body(
        selectInput(
          ns("dataset_menu"),
          "Select a dataset:",
          choices = c("iris", "cars", "penguins"),
          selected = "iris"
        ),
        div(
          class = "mt-3",
          h4("Selected Dataset:"),
          textOutput(ns("dataset_info"))
        )
      )
    ),
    card(
      card_header("Bar Chart"),
      card_body(
        plotOutput(ns("bar_chart"), height = "400px")
      )
    )
  )
}


#' dataAnalysis Server Functions
#' @param dataset_selection Reactive containing selected dataset
#' @param processed_data Reactive containing processed count data
modA_dataAnalysisApp_server <- function(id, dataset_selection, processed_data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Update shared reactive when local input changes
    observe({
      dataset_selection(input$dataset_menu)
    }) |> bindEvent(input$dataset_menu)

    # Dataset info
    output$dataset_info <- renderText({
      req(dataset_selection())
      generate_data_text(dataset_selection())
    })

    # Create bar chart
    output$bar_chart <- renderPlot({
      req(processed_data(), dataset_selection())

      data <- processed_data()
      dataset_name <- dataset_selection()

      # Get the grouping variable name
      x_var <- switch(dataset_name,
                      "iris" = "Species",
                      "cars" = "manufacturer",
                      "penguins" = "species"
      )

      ggplot(data, aes(x = .data[[x_var]], y = count, fill = .data[[x_var]])) +
        geom_col() +
        labs(title = paste(toTitleCase(dataset_name), ": Count by",
                           ifelse(dataset_name == "cars", "Manufacturer", "Species")),
             x = NULL, y = "Count") +
        theme_minimal() +
        theme(
          plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
          axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = "none"
        )
    })
  })
}


# Dummy App for Module A

ui <- fluidPage(
  titlePanel("Test: Bar Chart Module"),
  modA_dataAnalysisApp_ui("test")
)

server <- function(input, output, session) {
  modA_dataAnalysisApp_server("test")
}

shinyApp(ui, server)
