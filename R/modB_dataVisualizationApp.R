# Modul B: Output eines scatter plots (je nach ausgewählten Datensatz im Menü von Modul A)

#' Module B: dataVisualizationApp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
modB_dataVisualizationApp_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h3("Scatter Plot Visualization"),
    plotOutput(ns("scatter_plot"), height = "500px"),
  )
}


#' Module B: Scatter Plot Server Function
#'
#' @param selected_dataset Reactive value from Module A
#' @noRd
modB_dataVisualizationApp_server <- function(id, selected_dataset) {
  moduleServer(id, function(input, output, session) {

    # Get current dataset based on Module A selection
    current_data <- reactive({req(selected_dataset())

      switch(selected_dataset(),
             "iris" = iris,
             "cars" = cars,
             "penguins" = palmerpenguins::penguins)
    })

    # Create scatter plot
    output$scatter_plot <- renderPlot({
      req(current_data())

      data <- current_data()
      dataset_name <- selected_dataset()

      if(dataset_name == "iris") {
        # Iris: Sepal Length vs Sepal Width
        plot(data$Sepal.Length, data$Sepal.Width,
             main = "Iris: Sepal Length vs Sepal Width",
             xlab = "Sepal Length (cm)",
             ylab = "Sepal Width (cm)",
             col = as.factor(data$Species),
             pch = 19, cex = 1.5)
        legend("topright",
               legend = levels(as.factor(data$Species)),
               col = 1:3, pch = 19,
               title = "Species")

      } else if(dataset_name == "cars") {
        # Cars: Speed vs Distance
        plot(data$speed, data$dist,
             main = "Cars: Speed vs Stopping Distance",
             xlab = "Speed (mph)",
             ylab = "Stopping Distance (ft)",
             col = "blue", pch = 19, cex = 1.5)
        # Add trend line
        abline(lm(dist ~ speed, data = data), col = "red", lwd = 2)

      } else if(dataset_name == "penguins") {
        # Penguins: Bill Length vs Bill Depth
        # Remove rows with missing values
        data_clean <- data[complete.cases(data$bill_length_mm, data$bill_depth_mm), ]

        plot(data_clean$bill_length_mm, data_clean$bill_depth_mm,
             main = "Penguins: Bill Length vs Bill Depth",
             xlab = "Bill Length (mm)",
             ylab = "Bill Depth (mm)",
             col = as.factor(data_clean$species),
             pch = 19, cex = 1.5)
        legend("topright",
               legend = levels(as.factor(data_clean$species)),
               col = 1:3, pch = 19,
               title = "Species")
      }
    })

    # Plot description
    output$plot_description <- renderText({
      descriptions <- list(
        "iris" = "Relationship between sepal length and width, by species.",
        "cars" = "Speed vs stopping distance.",
        "penguins" = "Bill length vs depth measurements, by penguin species."
      )

      descriptions[[selected_dataset()]]
    })
  })
}

# # Simple test app
# library(golem)
#
# ui<- fluidPage(
#   modB_dataVisualizationApp_ui("test")
# )
#
# server <- function(input, output, session) {
#   modB_dataVisualizationApp_server("test", selected_dataset = reactive("penguins"))
# }
#
# shinyApp(ui, server)
