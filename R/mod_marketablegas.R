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
  shiny::mainPanel(
    shiny::fluidPage(
      shiny::tags$h3("Daily Average Production", style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::tags$h4("Production Across The Province", style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::fluidRow(
        shiny::column(
          width = 3,
          style = "background-color: black; color: white; padding: 10px;",
          shiny::tags$h4("Series Selection:", style = "color: white;"),
          shiny::tags$p("Select the series to display:", style = "color: white;"),
          shiny::uiOutput(ns("series_selector"))
        ),
        shiny::column(
          width = 9,
          plotly::plotlyOutput(ns("marketablegas"))
        )
      ),
      shiny::fluidRow(
        shiny::column(
          width = 12,
          style = "background-color: #ECF0F1; padding: 20px; box-sizing: border-box;",
          shiny::tags$h4(" Natural Gas in Alberta: Production", style = "color: #333; margin-bottom: 20px;"),
          shiny::tags$p("This interactive graph represents the daily average production
          of natural gas within Alberta, segmented by different geographic and resource
          classifications known as Petroleum Services Association of Canada (PSAC) areas.
          These areas represent divisions within Alberta where natural gas exploration and
          extraction activities are grouped based on geographic, geological, and infrastructural factors.", style = "margin-bottom: 10px;"),
          shiny::tags$p("These areas represent divisions within Alberta where natural
                        gas exploration and extraction activities are grouped based on geographic, geological, and infrastructural factors.
                        Understanding the PSAC Areas: PSAC 1 (Foothills): This area encompasses the mountainous regions where extraction can be more challenging due to the terrain.
PSAC 2 (Foothills Front): Adjacent to the Foothills, this area includes the front ranges where the foothills meet the plains.
PSAC 3 (Southeastern AB): Located in the southeastern part of Alberta, known for its productive gas fields.
PSAC 4 (East Central AB): This central region benefits from a mix of agricultural and resource extraction economies.
PSAC 5 (Central AB): The heart of Alberta, often characterized by diversified production including both oil and gas.
PSAC 6 (Northeastern AB): This area includes parts of the vast boreal forest and is key to the oil sands development.
PSAC 7 (Northwestern AB): Encompasses the northwestern territories, including high potential unconventional gas resources.", style = "margin-bottom: 10px;"),
          shiny::tags$p("Gas from Oil Wells: Represents natural gas production that is a byproduct of oil extraction processes.
Shale Gas: Reflects the production from shale formations, often requiring hydraulic fracturing and horizontal drilling techniques.
The line graph overlays these different production types, showing their contribution to the total daily average production over time.
                        The shaded areas under the lines help visualize the volume of production and how it changes year over year.",
                        style = "margin-bottom: 10px;")
        )
      )
    )
  )
}




#' marketablegas Server Functions
#'
#' @noRd
mod_marketablegas_server <- function(id, r){
  moduleServer(id, function(input, output, session){
    ns <- session$ns


    output$series_selector <- renderUI({
      choices <- unique(r$s1$series)
      shiny::checkboxGroupInput(ns("selected_series"),
                                label = "Select Series:",
                                choices = choices,
                                selected = choices)
    })


    output$marketablegas <- plotly::renderPlotly({
      req(input$selected_series)
      filtered_data <- r$s1 %>%
        dplyr::filter(series %in% input$selected_series)

      plotly::plot_ly(
        data = filtered_data,
        x = ~Year,
        y = ~value,
        color = ~series,
        type = 'scatter',
        mode = 'lines+markers',
        fill = 'tozeroy'
      ) %>%
        plotly::layout(
          yaxis = list(title = "Million Cubic Metres Per Day"),
          xaxis = list(title = "")
        )
    })
  })
}


## To be copied in the UI
# mod_marketablegas_ui("marketablegas_1")

## To be copied in the server
# mod_marketablegas_server("marketablegas_1")
