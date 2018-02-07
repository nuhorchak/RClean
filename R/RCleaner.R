#' @title RClean gadget
#'
#' @description interactive data cleaning
#'
#' @param data The data to be used
#'
#' @import shiny
#'
#' @export
RCleaner <- function(data, ...) {

  ui <- miniPage(
    gadgetTitleBar("RClean - Interactive Data Cleaning"),
    miniContentPanel(
      DT::dataTableOutput("Main_table")
    )
  )

  server <- function(input, output, session) {

    output$Main_table <- DT::renderDataTable(data, server = TRUE
    )
    proxy <- DT::dataTableProxy('Main_table')
    # if(input$Main_table_row_last_clicked = NULL){
    #   print("No selection")} else {
    #
    #   }



    # Handle the Done button being pressed.
    observeEvent(input$done, {
      # Return the brushed points. See ?shiny::brushedPoints.
      stopApp(input$Main_table_row_last_clicked)
    })
  }

  runGadget(ui, server, viewer = dialogViewer("RCleaner"))
}
