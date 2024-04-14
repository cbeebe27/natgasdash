#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  r <- shiny::reactiveValues()
  r$s3 <- natgasdash::s3
  r$s1 <- natgasdash::s1
  r$s2 <- natgasdash::s2
  r$s4 <- natgasdash::s4
  r$s5 <- natgasdash::s5
  mod_bitumen_server("bitumen_1", r = r)
  mod_marketablegas_server("marketablegas_1", r = r)
  mod_wells_server("wells_1", r = r)
  mod_oilsands_server("oilsands_1", r = r)
  # Your application server logic
}


