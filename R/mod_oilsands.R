#' oilsands UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_oilsands_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::tabPanel("oilsands")

  )
  plotly::plotlyOutput(ns("oilsands"))


}

#' oilsands Server Functions
#'
#' @noRd
mod_oilsands_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$oilsands <- plotly::renderPlotly({
      r$s4 %>%
      plotly::plot_ly(x = ~Year,
                      y = ~values,
                      color = ~series,
                      type = 'scatter',
                      mode = 'lines+markers',
                      fill = 'tozeroy'
      ) %>%
      plotly::layout(title = 'Total Purchased, Processed and Produced Gas For Oil Sands Production',
                     xaxis = list(title = ''),
                     yaxis = list(title = 'Million Cubic Metres Per Day'))

})
  })
}

## To be copied in the UI
# mod_oilsands_ui("oilsands_1")

## To be copied in the server
# mod_oilsands_server("oilsands_1")
