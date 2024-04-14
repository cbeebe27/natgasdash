#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  r <- shiny::reactiveValues()
  r$s3 <- natgasdash::s3
  mod_bitumen_server("bitumen_1", r = r)
  # Your application server logic
}
