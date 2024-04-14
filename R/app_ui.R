#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      h1("AECO Natural Gas Historical Dashboard"),
      shiny::tabsetPanel(
        type = 'tabs',
        shiny::tabPanel("Daily Average Production", mod_marketablegas_ui("marketablegas_1")),
        shiny::tabPanel("Bitumen", mod_bitumen_ui("bitumen_1")),
        shiny::tabPanel("Wells", mod_wells_ui("wells_1")),
        shiny::tabPanel("Oilsands", mod_oilsands_ui("oilsands_1"))
    ))
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "natgasdash"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
