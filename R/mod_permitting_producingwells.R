#' permitting_producingwells UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_permitting_producingwells_ui <- function(id){
  ns <- NS(id)
  shiny::mainPanel(
    shiny::fluidPage(
      shiny::fluidRow( plotly::plotlyOutput(ns("permitting"))),
      shiny::fluidRow(plotly::plotlyOutput(ns("production")))
    )
  )
}

#' permitting_producingwells Server Functions
#'
#' @noRd
mod_permitting_producingwells_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$permitting <- plotly::renderPlotly({
      r$s9 %>% plotly::plot_ly(x = ~Year,
                             y = ~`Available for permitting`,
                             type = 'bar') %>%
        plotly::layout(title = 'Volumes Available For Permitting',
                       xaxis = list(title = ''),
                       yaxis = list(title = 'Billion Cubic Meters'))
    })

  output$prodution <- plotly::renderPlotly({
    r$s10 %>% tidyr::pivot_longer(cols = 2:5, names_to = 'series', values_to = 'value') %>%
      dplyr::filter(series %in% c("Horizontal", "Vertical")) %>%
      plotly::plot_ly(x = ~Year,
                      y = ~value,
                      color = ~series,
                      type = 'bar') %>%
      plotly::layout(barmode = 'stack',
                     title = 'Total Producing Wells',
                     xaxis = list(title = ''),
                     yaxis = list(title = "Wells"))


  })
  })
}

## To be copied in the UI
# mod_permitting_producingwells_ui("permitting_producingwells_1")

## To be copied in the server
# mod_permitting_producingwells_server("permitting_producingwells_1")
