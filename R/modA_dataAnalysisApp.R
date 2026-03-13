# Modul A: Dropdown-Menü mit Optionen iris, ggplot2::mpg und palmerpenguins::penguins.
# Bei Auswahl des Datensatzes wir eine Balkendiagramm erzeugt, grouped by

#' dataAnalysis UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @import bslib
#'
#' @importFrom shiny NS tagList
#'
#' @export
#'
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
#'
#' @noRd
modA_dataAnalysisApp_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Raw Data
    current_data <- reactive({
      req(input$dataset_menu)

      switch(input$dataset_menu,
             "iris" = iris,
             "cars" = ggplot2::mpg,
             "penguins" = palmerpenguins::penguins
      )
    })

    # Grouped Data - Consistent count format for ALL datasets
    processed_data <- reactive({
      req(current_data(), input$dataset_menu)

      library(dplyr)
      data <- current_data()
      dataset_name <- input$dataset_menu

      if(dataset_name == "iris") {
        data |> count(Species, name = "count")
      } else if(dataset_name == "cars") {
        data |> count(manufacturer, name = "count")
      } else if(dataset_name == "penguins") {
        data |>
          filter(!is.na(species)) |>
          count(species, name = "count")
      }
    })

    # Dataset info
    output$dataset_info <- renderText({
      generate_data_text(input$dataset_menu)
    })

    # Create bar chart
    output$bar_chart <- renderPlot({
      req(processed_data(), input$dataset_menu)

      library(ggplot2)
      data <- processed_data()
      dataset_name <- input$dataset_menu

      # Get the grouping variable name
      x_var <- switch(dataset_name,
                      "iris" = "Species",
                      "cars" = "manufacturer",
                      "penguins" = "species"
      )

      ggplot(data, aes(x = .data[[x_var]], y = count, fill = .data[[x_var]])) +
        geom_col() +
        labs(title = paste(tools::toTitleCase(dataset_name), ": Count by",
                           ifelse(dataset_name == "cars", "Manufacturer", "Species")),
             x = NULL, y = "Count") +
        theme_minimal() +
        theme(
          plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
          axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = "none"
        )
    })

    return(list(
      dataset_selection = reactive({input$dataset_menu}),
      processed_data = processed_data,
      raw_data = current_data
    ))
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
