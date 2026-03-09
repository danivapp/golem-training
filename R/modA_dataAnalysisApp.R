# Modul A: Dropdown-Menü mit Optionen iris, ggplot2::mpg und palmerpenguins::penguins.
# Bei Auswahl des Datensatzes wir eine Balkendiagramm erzeugt, grouped by

#' dataAnalysis UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
modA_dataAnalysisApp_ui <- function(id) {
  ns <- NS(id) # namespace System to prevent ID conflicts
  tagList(
    fluidRow(

      # Left Column
      column(4,
             wellPanel(
               h3("Dataset Selection"),
               selectInput(
                 inputId = ns("dataset_menu"),
                 label = "Select a dataset:",
                 choices = c( "iris","cars","penguins"),
                 selected = "iris"),
               br(),
               h4("Selected Dataset:"),
               textOutput(ns("dataset_info"))
             )
      ),


      # Right Column
      column(8,
             wellPanel(
               h4("📈 Bar Chart"),
               plotOutput(ns("bar_chart"), height = "400px")
             ))
    )
  )
}


#' dataAnalysis Server Functions
#'
#' @noRd
modA_dataAnalysisApp_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns



    # Get current dataset
    current_data <- reactive({
      req(input$dataset_menu)

      switch(input$dataset_menu,
             "iris" = iris,
             "cars" = ggplot2::mpg,
             "penguins" = palmerpenguins::penguins
      )
    })

    # Dataset info
    output$dataset_info <- renderText({
      data <- current_data()
      paste("Dataset:", input$dataset_menu, "- Rows:", nrow(data), "- Columns:", ncol(data))
    })

    # Create bar chart
    output$bar_chart <- renderPlot({
      req(current_data())

      data <- current_data()
      dataset_name <- input$dataset_menu

      if(dataset_name == "iris") {
        # Count by Species
        species_counts <- table(data$Species)
        barplot(species_counts,
                main = "Iris: Number of Observations by Species",
                xlab = "Species",
                ylab = "Count",
                col = c("red", "green", "blue"),
                las = 1)

      } else if(dataset_name == "cars") {
        # Count by Manufacturer
        manufacturer_counts <- table(data$manufacturer)
        barplot(manufacturer_counts,
                main = "MPG: Number of Cars by Manufacturer",
                xlab = "Manufacturer",
                ylab = "Count",
                col = rainbow(length(manufacturer_counts)),
                las = 2,  # Rotate labels
                cex.names = 0.7)  # Smaller text for readability

      } else if(dataset_name == "penguins") {
        # Count by Species (remove NAs)
        data_clean <- data[!is.na(data$species), ]
        species_counts <- table(data_clean$species)
        barplot(species_counts,
                main = "Penguins: Number of Observations by Species",
                xlab = "Species",
                ylab = "Count",
                col = c("orange", "purple", "cyan"),
                las = 1)
      }
    })

    # Return selected dataset for potential Module B
    return(reactive({
      input$dataset_menu
    }))
  })
}

# library(golem)
# library(shiny)
#
# ui <- fluidPage(
#   titlePanel("Test: Bar Chart Module"),
#   modA_dataAnalysis_ui("test")
# )
#
# server <- function(input, output, session) {
#   modA_dataAnalysis_server("test")
# }
#
# shinyApp(ui, server)
