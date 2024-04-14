#' marketablegas UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_marketablegas_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::tabPanel("marketablegas")

  )
  plotly::plotlyOutput(ns("marketablegas"))
}

#' marketablegas Server Functions
#'
#' @noRd
mod_marketablegas_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$marketablegas <- plotly::renderPlotly({
      r$s1 %>%
        plotly::plot_ly(
          x = ~Year,
          y = ~value,
          color = ~series,
          type = 'scatter',
          mode = 'lines+markers',
          fill = 'tozeroy'
        ) %>%
        plotly::layout(
          yaxis = list(title = "Million Cubic Metres Per Day"),
          xaxis = list(title = ""))
      })


  })
}

## To be copied in the UI
# mod_marketablegas_ui("marketablegas_1")

## To be copied in the server
# mod_marketablegas_server("marketablegas_1")
