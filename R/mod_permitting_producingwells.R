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
      shiny::tags$h3("Permitting Volume & Total Producing Wells", style = "color: black; text-align: center; margin-top: 20px;"),
      shiny::tags$h4("Cubic Meters Available For Permitting And Total Wells Online", style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::tags$p("The top chart, titled 'Cubic Meters Available For Permitting,'
                    illustrates the volume of natural gas that has been sanctioned for extraction over time, reflecting trends in the allocation of gas resources available
                    for development."),
      shiny::tags$p("The 'Total Producing Wells' chart tracks the operational wells categorized by their
                    orientation, providing insights into the growth of the industry and the adoption of different drilling techniques over the years."),
      shiny::tags$p("Together, these charts provide a comprehensive view of Alberta's energy landscape,
                    illustrating the relationship between regulatory approvals and production activity,
                    influenced by technological advancements, market demand, and regulatory policies."),
      shiny::fluidRow( plotly::plotlyOutput(ns("permitting"))),
      shiny::fluidRow( plotly::plotlyOutput(ns("production")))

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

  output$production <- plotly::renderPlotly({
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
