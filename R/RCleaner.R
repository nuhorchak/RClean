#' @title RClean gadget
#'
#' @description interactive data cleaning
#'
#' @param data The data to be used
#'
#' @import shiny
#' @import DT
#' @import miniUI miniPage
#' @importFrom shinythemes shinytheme
#'
#' @export
RCleaner <- function(data, ...) {

  ui <- miniUI::miniPage(
    gadgetTitleBar("RClean - Interactive Data Cleaning"),
    miniContentPanel(
      DT::dataTableOutput("Main_table")
    ),
    miniButtonBlock(actionButton("deleteRows", "Delete Rows"), actionButton("deleteCols", "Delete Cols"))
  )

  server <- function(input, output, session) {

    #create dataframe to manipulate
    values <- reactiveValues(dfWorking = data)
    
    #select rows to delete, unless no rows are selected 
    observeEvent(input$deleteRows, {
      if (!is.null(input$Main_table_rows_selected)) {
        values$dfWorking <- values$dfWorking[-as.numeric(input$Main_table_rows_selected),]
      }
    })
    
    #functionality not working yet
    #select cols to delete, unless no rows are selected 
    observeEvent(input$deleteCols, {
      if (!is.null(input$Main_table_columns_selected)) { 
        values$dfWorking <- values$dfWorking[,-as.numeric(input$Main_table_columns_selected)]
      }
    })
    
    output$Main_table <- DT::renderDataTable(values$dfWorking, 
                                             server = TRUE, 
                                             selection = list(target = 'row+column'))

    # Handle the Done button being pressed.
    observeEvent(input$done, {
      # Return the brushed points. See ?shiny::brushedPoints.
      stopApp(input$Main_table_rows_selected)
    })
  }

  shinygadgets::runGadget(ui, server, viewer = shinygadgets::dialogViewer("RCleaner"))
  
  #https://stackoverflow.com/questions/39136385/delete-row-of-dt-data-table-in-shiny-app
}
