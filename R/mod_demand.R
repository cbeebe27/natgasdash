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
      shiny::tags$h3("Demand", style = "color: black; text-align: center; margin-top: 20px;"),
      shiny::tags$h4("an Overview of Demand Across Various Sectors", style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::tags$p(
        "The Demand visualizations provide an overview
            of natural gas usage across various sectors in Alberta. The top chart, using stacked bars, quantifies
            the total gas demand for removals and by sector, painting a picture of consumption trends over the years.
            The line chart below offers a clearer view of each sector's demand trajectory, facilitating an easy comparison of
            consumption patterns across time. Together, these graphs serve as a tool for understanding sector-specific gas utilization and
            projecting future trends.",
        style = "color: #333;"),
      shiny::fluidRow(
        shiny::column(
          width = 3,
          style = "background-color: black; color: white; padding: 10px;",
          shiny::tags$h4("Series Selection:", style = "color: white;"),
          shiny::tags$p("Check the series you want to display on the bar chart:", style = "color: white;"),
          shiny::uiOutput(ns("action_buttons"))
        ),
        shiny::column(width = 9, plotly::plotlyOutput(ns("bar")))
      ),
      shiny::fluidRow(
        shiny::column(
          width = 3,
          style = "background-color: black; color: white; padding: 10px;",
          shiny::tags$h4("Series Filter:", style = "color: white;"),
          shiny::tags$p("Select a series to display on the line chart:", style = "color: white;"),
          shiny::uiOutput(ns("select_series_input"))
        ),
        shiny::column(width = 9, plotly::plotlyOutput(ns("line")))
      )
          )
        )



}




mod_demand_server <- function(id, r){
  moduleServer(id, function(input, output, session){
    ns <- session$ns


    series_names <- reactive({
      c("All", names(r$s7)[-1])
    })


    output$action_buttons <- renderUI({
      req(series_names())
      shiny::checkboxGroupInput(ns("selected_series"), "Select series:",
                                choices = series_names(),
                                selected = series_names())
    })


    output$select_series_input <- renderUI({
      shiny::selectInput(ns("select_series"), "Select Series",
                         choices = series_names(),
                         selected = "All")
    })


    output$bar <- plotly::renderPlotly({
      req(input$selected_series)

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


    output$line <- plotly::renderPlotly({
      req(input$select_series)

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
