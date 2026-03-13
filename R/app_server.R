#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # # Load dependencies
  # load_app_dependencies()

# App 1: Basic dropdown
  mod_basicDropdownApp_server("basicDropdownApp_1")

# App 2: Data visualization modules
  dataset_selection_app2 <- reactiveVal("iris")

  current_data_app2 <- reactive({
    req(dataset_selection_app2())
    switch(dataset_selection_app2(),
           "iris" = iris,
           "cars" = cars,
           "penguins" = palmerpenguins::penguins)
  })

  modA_dataVisualizationApp_server("moduleA", dataset_selection_app2, current_data_app2)
  modB_dataVisualizationApp_server("moduleB", dataset_selection_app2, current_data_app2)

# App 3: Data Analysis
  dataset_selection <- reactiveVal("iris")

  processed_data <- reactive({
    req(dataset_selection())
    dataset_name <- dataset_selection()
    raw_data <- get_dataset_by_name(dataset_name)
    generate_processed_counts(dataset_name, raw_data)
  })

  modA_dataAnalysisApp_server("barChartApp", dataset_selection, processed_data)
  modB_dataAnalysisApp_server("dataAnalysisApp", dataset_selection, processed_data)

# App 4: Dashboard Cards
  shared_satisfaction_data <- reactive({
    data.frame(
      Kategorie = c("Service", "Qualität", "Preis"),
      Bewertung = c(4.2, 4.5, 3.8)
    )
  })

  shared_nps_data <- reactive({
    data.frame(
      Segment = c("Promoters", "Passives", "Detractors"),
      Anteil = c(65, 25, 10)
    )
  })

  observeEvent(input$refresh_dashboard, {
    showNotification("Noch keine Funktion.", type = "warning", duration = 3)
  })

  modA_dashboardCardsApp_server("dashboardA", shared_satisfaction_data)
  modB_dashboardCardsApp_server("dashboardB", shared_nps_data)

# App 5: Interactive Dashboard
  button_clicked_app5 <- reactiveVal(FALSE)
  refresh_count_app5 <- reactiveVal(0)

  shared_satisfaction_data_app5 <- reactive({

    req(button_clicked_app5(), refresh_count_app5())

    set.seed(123 + refresh_count_app5())
    data.frame(
      Kategorie = c("Service", "Qualität", "Preis"),
      Bewertung = round(runif(3, min = 3.0, max = 5.0), 1)
    )
  })


  shared_nps_data_app5 <- reactive({

    req(button_clicked_app5(), refresh_count_app5())

    set.seed(456 + refresh_count_app5())
    promoters <- sample(50:75, 1)
    detractors <- sample(5:20, 1)
    passives <- 100 - promoters - detractors

    data.frame(
      Segment = c("Promoters", "Passives", "Detractors"),
      Anteil = c(promoters, passives, detractors)
    )
  })


  observeEvent(input$refresh_interactive, {
    button_clicked_app5(TRUE)
    refresh_count_app5(refresh_count_app5() + 1)
    showNotification("Daten aktualisiert.", type = "message", duration = 3)
  })


  modA_dashboardCardsApp_server("app5_moduleA", shared_satisfaction_data_app5)
  modB_dashboardCardsApp_server("app5_moduleB", shared_nps_data_app5)
}
