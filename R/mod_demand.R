#' demand UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_demand_ui <- function(id) {
  ns <- NS(id)
  shiny::mainPanel(
    shiny::fluidPage(
      shiny::fluidRow(
        shiny::column(3, shiny::uiOutput(ns("action_buttons"))),
        shiny::column(9, plotly::plotlyOutput(ns("bar")))
      ),
      shiny::fluidRow(
        shiny::column(3, shiny::selectInput(ns("select_series"), "Select Series:", choices = c("All",
                                                                                               "Commercial",
                                                                                               "Residential",
                                                                                               "Transportation",
                                                                                               "Electricity -generation",
                                                                                               "Industrial - oil sands",
                                                                                               "Industrial - petrochemical",
                                                                                               "Other - industrial",
                                                                                               "Removals",
                                                                                               "Reprocessing plant shrinkage"))),
        shiny::column(9, plotly::plotlyOutput(ns("line")))
      )
    )
  )
}


mod_demand_server <- function(id, r){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Reactive for storing the series options
    series_names <- reactive({
      c("All", names(r$s7)[-1])
    })

    # Action buttons for the bar chart
    output$action_buttons <- renderUI({
      req(series_names())
      shiny::checkboxGroupInput(ns("selected_series"), "Select series:",
                                choices = series_names(),
                                selected = series_names())
    })

    # Dropdown for the line chart
    output$select_series_input <- renderUI({
      shiny::selectInput(ns("select_series"), "Select Series",
                         choices = series_names(),
                         selected = "All")
    })

    # Render the bar chart based on the checkbox selection
    output$bar <- plotly::renderPlotly({
      req(input$selected_series)
      # Use the selected series to filter the data
      data <- r$s7 %>%
        tidyr::pivot_longer(cols = -Year, names_to = 'series', values_to = 'value') %>%
        dplyr::filter(series %in% input$selected_series)

      plotly::plot_ly(
        data = data,
        x = ~Year,
        y = ~value,
        color = ~series,
        type = 'bar'
      ) %>%
        plotly::layout(barmode = 'stack',
                       title = 'Marketable Gas Available For Removals and Demand by Sector',
                       xaxis = list(title = ''),
                       yaxis = list(title = 'Million Cubic Meters'))

    })

    # Render the line chart based on dropdown input
    output$line <- plotly::renderPlotly({
      req(input$select_series)
      # If "All" is selected, use all series, else filter for the selected series
      data <- if (input$select_series == "All") {
        r$s7
      } else {
        r$s7 %>%
          dplyr::select(Year, all_of(input$select_series))
      }

      plotly::plot_ly(
        data = data %>%
          tidyr::pivot_longer(cols = -Year, names_to = 'series', values_to = 'value'),
        x = ~Year,
        y = ~value,
        color = ~series,
        type = 'scatter',
        mode = 'lines+markers'
      ) %>%
        plotly::layout(title = '',
                       xaxis = list(title = ''),
                       yaxis = list(title = 'Million Cubic Meters'))
    })
  })
}



## To be copied in the UI
# mod_demand_ui("demand_1")

## To be copied in the server
# mod_demand_server("demand_1")
