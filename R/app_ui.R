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
          shinydashboard::menuItem("Production", tabName = "daily_avg_prod", icon = icon("chart-line")),
          shinydashboard::menuItem("Demand", tabName = "demand", icon = icon("balance-scale")),
          shinydashboard::menuItem("Bitumen", tabName = "bitumen", icon = icon("oil-can")),
          shinydashboard::menuItem("New Wells", tabName = "wells", icon = icon("dot-circle")),
          shinydashboard::menuItem("Total Producing Wells", tabName = "demand", icon = icon("square-plus")),
          shinydashboard::menuItem("Oilsands", tabName = "oilsands", icon = icon("mountain"))
        )
      ),
      shinydashboard::dashboardBody(
        shinydashboard::tabItems(
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
      /* Custom styles for a professional look */
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

mod_demand_server <- function(id, r){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Dynamically generating the list of series names from the reactive 'r'
    series_names <- reactive({
      c("All", unique(r()$series))
    })

    # Observe any change in the checkbox inputs for the line chart series selection
    observe({
      req(series_names())
      series_list <- series_names()
      for (series_name in series_list[-1]) { # Exclude "All"
        if (is.null(input[[series_name]])) {
          series_selected[[series_name]] <- TRUE # Default to TRUE
        } else {
          series_selected[[series_name]] <- input[[series_name]]
        }
      }
    })

    # Render the dropdown for selecting series on the bar chart
    output$select_series_input <- renderUI({
      selectInput(ns("select_series"), "Select Series:",
                  choices = series_names(),
                  selected = "All")
    })

    # Render the bar chart
    output$bar <- plotly::renderPlotly({
      req(input$select_series)
      if (input$select_series == "All") {
        data <- r()  # Use all data if "All" is selected
      } else {
        data <- r() %>%
          dplyr::select(Year, all_of(input$select_series))
      }

      plot_ly(data = data,
              x = ~Year,
              y = ~value,
              color = ~series,
              type = 'bar') %>%
        layout(barmode = 'stack')
    })

    # Render the line chart
    output$line <- plotly::renderPlotly({
      req(series_selected)
      # Determine which series to plot
      series_to_plot <- names(series_selected)[series_selected]

      data_long <- r() %>%
        tidyr::pivot_longer(cols = 2:10, names_to = 'series', values_to = 'value') %>%
        dplyr::filter(series %in% series_to_plot)

      plot_ly(data = data_long,
              x = ~Year,
              y = ~value,
              color = ~series,
              type = 'scatter',
              mode = 'lines+markers')
    })

    # UI output for the checkboxes used to select series for the line chart
    output$action_buttons <- renderUI({
      req(series_names())
      checkboxGroupInput(ns("selected_series"), "Select series:",
                         choices = setNames(series_names(), series_names()),
                         selected = series_names())
    })

    # Observer for the checkboxes to update the selected series
    observe({
      updateReactiveValues(series_selected, input$selected_series)
    })
  })
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
