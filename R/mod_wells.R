#' wells UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_wells_ui <- function(id){
  ns <- NS(id)
    shiny::mainPanel(
      shiny::fluidPage(
        shiny::fluidRow( plotly::plotlyOutput(ns("wells"))),
        shiny::fluidRow(plotly::plotlyOutput(ns("cbmshale")))
      )
    )



}

#' wells Server Functions
#'
#' @noRd
mod_wells_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$wells <- plotly::renderPlotly({
      r$s2 %>%
        dplyr::filter(HVM == 'Horizontal' | HVM == 'Vertical') %>%
        plotly::plot_ly(x = ~Year,
                        y = ~`Wells placed on production`,
                        color = ~HVM,
                        type = 'bar') %>%
        plotly::layout(title = 'Wells Placed On Production',
                       xaxis = list(title = ''),
                       yaxis = list(title = 'Wells'))

    })

    output$cbmshale <- plotly::renderPlotly({
      r$s5 %>% dplyr::select(1:3) %>%
        tidyr::pivot_longer(cols = 2:3, names_to = 'series', values_to = 'values') %>%
        plotly::plot_ly(x = ~Year,
                        y = ~values,
                        color = ~series,
                        type = 'bar') %>%
        plotly::layout(title = 'CBM & Shale Gas Vs. Gas Wells',
                       xaxis = list(title = ''),
                       yaxis = list(title = 'Wells Placed On Production'))

    })

  })
}

## To be copied in the UI
# mod_wells_ui("wells_1")

## To be copied in the server
# mod_wells_server("wells_1")
