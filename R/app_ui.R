

#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import bslib
#' @noRd
app_ui <- function(request) {
  library(bslib)

  tagList(
    # Leave this function for adding external resources
    # golem_add_external_resources(),
    # Your application UI logic
    page_navbar(
      title = "Golem Training",

      # App1: basicDropdownApp
      nav_panel(
        title = "App 1: Text Dropdown",
        value = "app1",
        div(
          class = "mt-3",
          mod_basicDropdownApp_ui("basicDropdownApp_1")
        )
      ),

      # App2: dataVisualizationApp
      nav_panel(
        title = "App 2: Data Visualization",
        value = "app2",
        div(
          class = "mt-3",
          layout_column_wrap(
            width = 1/2,
            card(
              card_header("Dataset Selection"),
              card_body(
                modA_dataVisualizationApp_ui("moduleA")
              )
            ),
            card(
              card_header("Visualization"),
              card_body(
                modB_dataVisualizationApp_ui("moduleB")
              )
            )
          )
        )
      ),

      # App3: dataAnalysisApp
      nav_panel(
        title = "App 3: Data Analysis",
        value = "app3",
        div(
          class = "mt-3",
          layout_column_wrap(
            width = 1/2,  # This keeps modules side by side
            modA_dataAnalysisApp_ui("barChartApp"),
            modB_dataAnalysisApp_ui("dataAnalysisApp")
          )
        )
      ),

      # App4: dashboardCardsApps
      nav_panel(
        title = "App 4: Dashboard Cards",
        value = "app4",
        div(
          class = "mt-3",
          div(
            class = "mb-3 text-center",
            actionButton("refresh_dashboard", "Daten aktualisieren",
                         class = "btn-primary btn-lg")
          ),
          layout_column_wrap(
            width = 1/2,
            modA_dashboardCardsApp_ui("dashboardA"),
            modB_dashboardCardsApp_ui("dashboardB")
          )
        )
      ),

      # App5: interactiveDashboardApp
      nav_panel(
        title = "App 5: Interactive Dashboard",
        value = "app5",
        div(
          class = "mt-3",
          div(
            class = "mb-3 text-center",
            actionButton("refresh_interactive", "Daten aktualisieren",
                         class = "btn-primary btn-lg")
          ),
          layout_column_wrap(
            width = 1/2,
            modA_dashboardCardsApp_ui("app5_moduleA"),
            modB_dashboardCardsApp_ui("app5_moduleB")
          )
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
