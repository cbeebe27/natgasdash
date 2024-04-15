#' overview UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_overview_ui <- function(id) {
  ns <- NS(id)
  shiny::mainPanel(
    shiny::fluidPage(
      shiny::tags$h3("AECO Natural Gas Interactive Dashboard Overview", style = "color: #333; text-align: center; margin-top: 20px;"),
      shiny::tags$p("The AECO Natural Gas Interactive Dashboard is a tool designed to present the annual AECO data release
                    in a dynamic and engaging manner. Aimed at enhancing understanding and analysis, the dashboard serves as a platform for
                    visualizing and interacting with Alberta's natural gas production, demand, and well distribution data.",
                    style = "color: #333; text-align: justify; margin: 20px;"),
      shiny::tags$p("Users can explore various aspects of the natural gas market, including detailed production statistics, bitumen upgrading activities,
                    and comprehensive well data. With the ability to filter and drill down into specific variables, users can gain insights into different
                    relationships and view different trends by looking at the data in a way not seen in the release.",
                    style = "color: #333; text-align: justify; margin: 20px;"),
      shiny::tags$p("To navigate the dashboard, select the desired tab from the sidebar. Interactive elements such as dropdown menus and checkboxes allow for a customized viewing experience,
                    presenting the data in an array of graphical representations. Whether you are analyzing trends over time, comparing geographic regions, or examining specific types of gas production,
                    the dashboard offers a user-friendly interface to accommodate diverse analytical needs.",
                    style = "color: #333; text-align: justify; margin: 20px;"),
      shiny::tags$p("Users are encouraged to leverage the filtering capabilities for a more tailored analysis experience.
                    Hopefully this dadhboard assists in telling the story behind Alberta's natural gas history.",
                    style = "color: #333; text-align: justify; margin: 20px;"),
      shiny::tags$div(style = "height: 100%; overflow-y: auto;") # Ensure the content is scrollable
    )
  )
}


mod_overview_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_overview_ui("overview_1")

## To be copied in the server
# mod_overview_server("overview_1")
