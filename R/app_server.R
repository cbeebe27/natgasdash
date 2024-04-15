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
  r$s2p <- natgasdash::s2p
  r$s4 <- natgasdash::s4
  r$s5 <- natgasdash::s5
  r$s5l <- natgasdash::s5l
  r$s7 <- natgasdash::s7
  r$s9 <- natgasdash::s9
  r$s10 <- natgasdash::s10
  mod_bitumen_server("bitumen_1", r = r)
  mod_marketablegas_server("marketablegas_1", r = r)
  mod_wells_server("wells_1", r = r)
  mod_oilsands_server("oilsands_1", r = r)
  mod_demand_server("demand_1", r = r)
  mod_permitting_producingwells_server("permitting_producingwells_1", r = r)
  mod_overview_server("overview_1")
  # Your application server logic
}


