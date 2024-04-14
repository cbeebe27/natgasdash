#' bitumen UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_bitumen_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::tabPanel("bitumen")

  )
 plotly::plotlyOutput(ns("Bitumen"))
}

#' bitumen Server Functions
#'
#' @noRd
mod_bitumen_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$Bitumen <- plotly::renderPlotly({
      r$s3 %>%
        tidyr::pivot_longer(cols = 2:3,
                            names_to = "type",
                            values_to = "value") %>%
        plotly::plot_ly(x = ~Year,
                        y = ~value,
                        color = ~type,
                        type = 'bar') %>%
        plotly::layout(yaxis = list(title = "Million Cubic Metres Per Day"),
                       xaxis = list(title = ""))})
  })
}

## To be copied in the UI
# mod_bitumen_ui("bitumen_1")

## To be copied in the server
# mod_bitumen_server("bitumen_1")
