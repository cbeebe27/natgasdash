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
    shiny::wellPanel(
      shiny::tabPanel("Oilsands",
                      div(style = "text-align: center; margin-bottom: 20px;",
                          h2("Natural Gas For Oilsands ", style = "color: white;"),
                          h4("Total Purchased, Processed and Produced Gas For Oil Sands Production", style = "color: white;")
                      ),
                      div(id = ns("plot_container"),
                          plotly::plotlyOutput(ns("oilsands"), height = "600px")
                      ),
                      div(style = "margin-top: 20px; padding: 10px; background-color: #121212; border-radius: 5px; color: white;",
                          h3("Filter by Series:"),
                          p("Select the variables to filter the data displayed on the chart.", style = "color: white;"),
                          shiny::checkboxGroupInput(
                            ns("selected_series"),
                            label = NULL,
                            choices = NULL,  # This will be populated in the server function
                            selected = NULL,  # Default to all selected
                            inline = FALSE  # Set to FALSE if you want the checkboxes to appear vertically
                          )
                      ),
                      tags$style(HTML("
          #${ns('plot_container')} .plot-container.plotly {
            background-color: #A9A9A9; /* Very dark grey for the plot background */
          }
          .shiny-input-checkboxgroup label {
            font-weight: bold;
            color: white;
            display: block; /* Make labels display as block to have them vertically aligned */
          }
          .shiny-input-checkboxgroup .checkbox {
            display: block;
            margin: 5px 0px;
          }
          .well {
            background-color: #00274c; /* Very dark blue */
            border: none;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
          }
          .well > h2, .well > h4, .well > div > p {
            color: white;
          }
        "))
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
