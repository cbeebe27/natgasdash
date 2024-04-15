#' oilsands UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_oilsands_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shiny::fluidPage(
      shiny::tags$h3("Oilsands", style = "color: black; text-align: center; margin-top: 20px;"),
      shiny::tags$h4("Natural Gas And Its Use In Oilsands Production", style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::tags$p("This chart illustrates the dynamic usage of natural gas in the oilsands sector of Alberta. It captures the total gas used for mining and upgrading,
                    in situ recovery, and electricity cogeneration related to oilsands production.
                    It reflects the integral role of natural gas as both an energy source and a raw material in oilsands operations,
                    underlining its significance in the energy value chain and the region's economic framework."),
      shiny::fluidRow(
        shiny::column(
          width = 3,
          div(style = "padding: 10px; background-color: #121212; border-radius: 5px; color: white;",
              h3("Filter by Series:", style = "color: white;"),
              p("Select the variables to filter the data displayed on the chart.", style = "color: white;"),
              shiny::checkboxGroupInput(
                ns("selected_series"),
                label = NULL,
                choices = NULL,  # This will be populated dynamically in the server function
                selected = NULL,
                inline = FALSE
              )
          )
        ),
        shiny::column(
          width = 9,
          div(id = ns("plot_container"),
              plotly::plotlyOutput(ns("oilsands"), height = "600px")
          )
        )
      )
    )
  )
}







#' oilsands Server Functions
#'
#' @noRd
mod_oilsands_server <- function(id, r){
  moduleServer(id, function(input, output, session){
    ns <- session$ns


    series_choices <- reactive({
      unique(r$s4$series)
    })


    observe({
      updateCheckboxGroupInput(session, "selected_series",
                               choices = series_choices(),
                               selected = series_choices())
    })


    output$oilsands <- plotly::renderPlotly({
      req(r$s4)
      filtered_data <- r$s4 %>%
        dplyr::filter(r$s4$series %in% input$selected_series)

      plotly::plot_ly(
        data = filtered_data,
        x = ~Year,
        y = ~values,
        color = ~series,
        type = 'scatter',
        mode = 'lines+markers',
        fill = 'tozeroy'
      ) %>%
        plotly::layout(
          title = 'Total Purchased, Processed and Produced Gas For Oil Sands Production',
          xaxis = list(title = ''),
          yaxis = list(title = 'Million Cubic Metres Per Day')
        )
    })
  })
}

## To be copied in the UI
# mod_oilsands_ui("oilsands_1")

## To be copied in the server
# mod_oilsands_server("oilsands_1")
