#' bitumen UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_bitumen_ui <- function(id) {
  ns <- NS(id)
  shiny::mainPanel(
    shiny::fluidPage(
      shiny::tags$h3("Bitumen", style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::tags$h4("Average Daily Gas Production From Bitumen Upgrading And Bitumen Wells",
                     style = "color: #333; text-align: center; margin-top: 5px;"),
      shiny::tags$p("This bar chart represents the average daily production of gas from bitumen upgrading processes and bitumen wells,
                    demonstrating the significant contribution of Alberta's oil sands to the province's natural gas output.
                    The visualization helps users track and analyze the production volumes over time, facilitating insights
                             into trends and potential future production shifts.",
                    style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::fluidRow(
        shiny::column(
          width = 12,
          plotly::plotlyOutput(ns("Bitumen"), height = "600px")
        )
        )
      )
    )
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


