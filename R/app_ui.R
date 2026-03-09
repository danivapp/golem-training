

#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    # golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      titlePanel("Golem Training"),

      # Create tabs for different apps
      tabsetPanel(

        # App1: basicDropdownApp
        tabPanel(
          title = "App 1: Text Dropdown",
          value = "app1",
          br(),
          mod_basicDropdownApp_ui("basicDropdownApp_1")
        ),


        # App2: dataVisualizationApp
        tabPanel(
          title = "App 2: Data Visualization",
          value = "app2",
          br(),
          fluidRow(
            # Module A (dropdown)
            column(4,
                   wellPanel(
                     h4("Dataset Selection"),
                     modA_dataVisualizationApp_ui("moduleA")
                   )
            ),
            # Module B (scatterplots)
            column(8,
                   wellPanel(
                     h4("Scatter Plot"),
                     modB_dataVisualizationApp_ui("moduleB")
                   )
            )

          )
        ),

        # App3: dataAnalysisApp
        tabPanel(
          title = "App 3: Data Analysis",
          value = "app3",
          br(),
          fluidRow(
            # Left half: Module A (bar chart)
            column(6,
                   modA_dataAnalysisApp_ui("barChartApp")
            ),
            # Right half: Module B (data table)
            column(6,
                   wellPanel(
                     modB_dataAnalysisApp_ui("dataAnalysisApp")
                   )
            )
          )
        ),

        # App4: dashboardCardsApps
        tabPanel(
          title = "App 4: Dashboard Cards",
          value = "app4",
          br(),
          fluidRow(

            # Left column: Module A (Gesamtzufriedenheit)
            column(6,
                   modA_dashboardCardsApp_ui("dashboardA")
            ),

            # Right column: Module B (NPS)
            column(6,
                   modB_dashboardCardsApp_ui("dashboardB")
            )
          )
        ),

        # App5: interactiveDashboardApp
        tabPanel(
          title = "App 5: Interactive Dashboard",
          value = "app5",
          br(),
          column(6, modA_interactiveDashboardApp_ui("app5_moduleA")),
          column(6, modB_interactiveDashboardApp_ui("app5_moduleB"))
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "myFirstGolem"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
