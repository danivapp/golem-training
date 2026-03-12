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

    library(ggplot2)

    # Get current dataset based on Module A selection
    current_data <- reactive({req(selected_dataset())

      switch(selected_dataset(),
             "iris" = iris,
             "cars" = cars,
             "penguins" = palmerpenguins::penguins
             )
    })

    # Create scatter plot
    output$scatter_plot <- renderPlot({
      req(current_data())

      data <- current_data()
      dataset_name <- selected_dataset()

      if(dataset_name == "iris") {
        # Iris: Sepal Length vs Sepal Width
        ggplot(data, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
          geom_point(size = 3, alpha = 0.7) +
          labs(title = "Iris: Sepal Length vs Sepal Width",
               x = "Sepal Length (cm)",
               y = "Sepal Width (cm)",
               color = "Species") +
          theme_minimal() +
          theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold")) +
          scale_color_viridis_d()

      } else if(dataset_name == "cars") {
        # Cars: Speed vs Distance
        ggplot(data, aes(x = speed, y = dist)) +
          geom_point(color = "blue", size = 3, alpha = 0.7) +
          geom_smooth(method = "lm", color = "red", se = TRUE, linewidth = 1.2) +
          labs(title = "Cars: Speed vs Stopping Distance",
               x = "Speed (mph)",
               y = "Stopping Distance (ft)") +
          theme_minimal() +
          theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

      } else if(dataset_name == "penguins") {
        # Penguins: Bill Length vs Bill Depth
        ggplot(data, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
          geom_point(size = 3, alpha = 0.7, na.rm = TRUE) +
          labs(title = "Penguins: Bill Length vs Bill Depth",
               x = "Bill Length (mm)",
               y = "Bill Depth (mm)",
               color = "Species") +
          theme_minimal() +
          theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold")) +
          scale_color_viridis_d()
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

# # Dummy App Module B
# library(golem)
#
# ui<- bslib::page_fluid(
#   modB_dataVisualizationApp_ui("test")
# )
#
# server <- function(input, output, session) {
#   modB_dataVisualizationApp_server("test", selected_dataset = reactive("iris"))
# }
#
# shinyApp(ui, server)
