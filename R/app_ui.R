#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
library(shiny)
library(shinydashboard)

library(shiny)
library(shinydashboard)

library(shiny)
library(shinydashboard)

app_ui <- function(request) {
  tagList(
    # External resources
    golem_add_external_resources(),
    # Application UI logic with a sophisticated look
    shinydashboard::dashboardPage(
      skin = "blue", # Change skin color as needed
      shinydashboard::dashboardHeader(
        title = div(style = "text-align: center; width: 100%;", "AECO Historical Dashboard"),
        titleWidth = 400  # Adjust width as needed to control the space allocated for the title
      ),
      shinydashboard::dashboardSidebar(
        width = 200,
        shinydashboard::sidebarMenu(
          shinydashboard::menuItem("Overview", tabName = "overview", icon = icon("info")),
          shinydashboard::menuItem("Production", tabName = "daily_avg_prod", icon = icon("chart-line")),
          shinydashboard::menuItem("Demand", tabName = "demand", icon = icon("balance-scale")),
          shinydashboard::menuItem("Bitumen", tabName = "bitumen", icon = icon("oil-can")),
          shinydashboard::menuItem("New Wells", tabName = "wells", icon = icon("dot-circle")),
          shinydashboard::menuItem("Total Producing Wells", tabName = "wellprod", icon = icon("square-plus")),
          shinydashboard::menuItem("Oilsands", tabName = "oilsands", icon = icon("mountain"))
        )
      ),
      shinydashboard::dashboardBody(
        shinydashboard::tabItems(
          shinydashboard::tabItem(tabName = "overview", mod_overview_ui("overview_1")),
          shinydashboard::tabItem(tabName = "daily_avg_prod", mod_marketablegas_ui("marketablegas_1")),
          shinydashboard::tabItem(tabName = "demand", mod_demand_ui("demand_1")),
          shinydashboard::tabItem(tabName = "bitumen", mod_bitumen_ui("bitumen_1")),
          shinydashboard::tabItem(tabName = "wells", mod_wells_ui("wells_1")),
          shinydashboard::tabItem(tabName = "wellprod", mod_permitting_producingwells_ui("permitting_producingwells_1")),
          shinydashboard::tabItem(tabName = "oilsands", mod_oilsands_ui("oilsands_1"))


        )
      )
    ),
    tags$head(tags$style(HTML("
      /*  */
      .skin-blue .main-header .navbar {
        background-color: #3498DB;
      }
      .skin-blue .main-header .logo {
        background-color: #2980B9;
        color: #FFFFFF;
        border-bottom: none;
        height: 50px;
        line-height: 50px; /* Vertically center the title text */
      }
      .skin-blue .main-sidebar {
        background-color: #3498DB;
      }
      .skin-blue .sidebar a {
        color: #FFFFFF;
      }
      .content-wrapper {
        background-color: #ECF0F1;
        overflow-x: hidden;
      }
    ")))
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
      app_title = "natgasdash"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
