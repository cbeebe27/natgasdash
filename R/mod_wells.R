#' wells UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_wells_ui <- function(id) {
  ns <- NS(id)
  shiny::mainPanel(
    shiny::fluidPage(
      shiny::tags$h3("New Wells", style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::tags$h4("Looking At Wells Placed On Production Through Time And CBM/Shale Vs. Gas", style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::tags$p("This visualization showcases the count of new wells placed on production over time, highlighting trends in traditional vertical drilling compared to horizontal drilling. The additional focus on Coalbed Methane (CBM) and shale wells versus conventional gas wells provides insights into the evolving landscape of gas extraction in Alberta.",
                    style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::fluidRow(
        shiny::column(
          width = 3,
          style = "background-color: black; color: white; padding: 10px;",
          shiny::tags$h4("Wells Selection:", style = "color: white;"),
          shiny::tags$p("Choose the well type to display on the production bar chart:", style = "color: white;"),
          shiny::selectInput(ns("well_type"), "Well Type",
                             choices = c("All", "Horizontal", "Vertical"),
                             selected = "All")
        ),
        shiny::column(width = 9, plotly::plotlyOutput(ns("wells")))
      ),
      shiny::fluidRow(
        shiny::column(
          width = 3,
          style = "background-color: black; color: white; padding: 10px;",
          shiny::tags$h4("Gas Type Selection:", style = "color: white;"),
          shiny::tags$p("Select the gas type for the second bar chart:", style = "color: white;"),
          shiny::selectInput(ns("gas_type"), "Gas Type",
                             choices = c("All", "Gas wells", "CBM and shale wells"),
                             selected = "All")
        ),
        shiny::column(width = 9, plotly::plotlyOutput(ns("cbmshale")))
      )
    )
  )
}



#' wells Server Functions
#'
#' @noRd
mod_wells_server <- function(id, r){
  moduleServer(id, function(input, output, session){
    ns <- session$ns


    output$well_type_selector <- renderUI({
      shiny::selectInput(ns("well_type"), "Well Type",
                         choices = c("All", unique(r$s2p$HVM)),
                         selected = "All")
    })


    output$gas_type_selector <- renderUI({
      shiny::selectInput(ns("gas_type"), "Gas Type",
                         choices = c("All", unique(r$s5l$series)),
                         selected = "All")
    })


    output$wells <- plotly::renderPlotly({
      data <- r$s2p
      if (input$well_type != "All") {
        data <- data %>% dplyr::filter(HVM == input$well_type)
      }

      plotly::plot_ly(data = data, x = ~Year,
                      y = ~`Wells placed on production`,
                      color = ~HVM,
                      type = 'bar') %>%
        plotly::layout(title = 'Wells Placed On Production',
                       xaxis = list(title = ''),
                       yaxis = list(title = 'Wells'))
    })


    output$gas_type_selector <- renderUI({
      shiny::selectInput(ns("gas_type"), "Gas Type",
                         choices = c("All",
                                     "Gas wells",
                                     "CBM and shale wells"),
                         selected = "All")
    })


    reactive_filtered_data <- reactive({
      if (input$gas_type == "All") {
        r$s5l
      } else {
        r$s5l %>% dplyr::filter(series == input$gas_type)
      }
    })


    output$cbmshale <- plotly::renderPlotly({
      req(reactive_filtered_data())
      data_to_plot <- reactive_filtered_data()

      plotly::plot_ly(
        data = data_to_plot,
        x = ~Year,
        y = ~values,
        color = ~series,
        type = 'bar',
        colors = c("Gas wells" = "blue", "CBM and shale wells" = "orange")
      ) %>%
        plotly::layout(
          title = 'CBM & Shale Gas Vs. Gas Wells',
          xaxis = list(title = 'Year'),
          yaxis = list(title = 'Wells Placed On Production'),
          barmode = 'group'
        )
    })
  })
}





## To be copied in the UI
# mod_wells_ui("wells_1")

## To be copied in the server
# mod_wells_server("wells_1")
