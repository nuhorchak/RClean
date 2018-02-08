#' @title RClean gadget
#'
#' @description interactive data cleaning
#'
#' @param data The data to be used
#'
#' @import DT
#' @import shiny
#' @importFrom pacman p_load p_load_gh
#' @import miniUI
#' @importFrom shinythemes shinytheme
#'
#' @export
RCleaner <- function(data, ...) {
  
  pacman::p_load(shiny, DT, miniUI)
  pacman::p_load_gh("rstudio/shinygadgets")

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
    #select cols to delete, unless no cols are selected 
    observeEvent(input$deleteCols, {
      if (!is.null(input$Main_table_columns_selected)) { 
        values$dfWorking <- values$dfWorking[,-as.numeric(input$Main_table_columns_selected)]
      }
    })
    
    output$Main_table <- DT::renderDataTable(values$dfWorking, 
                                             server = TRUE, 
                                             selection = list(target = 'row+column'))

    #BUTTON LOGIC
    # Handle the Done button being pressed.
    observeEvent(input$done, {
      # Return the modified datatable...not working yet
    stopApp(clean_data <<- data.frame(values$dfWorking))
    #stopApp(list(my_data = data.frame(values$dfWorking)))
    })
    
    #cancel logic - for some reason it stopped working
    observeEvent(input$cancel, {
      stopApp(print("User cancelled action"))
    })
    
    
  }

  shinygadgets::runGadget(ui, server, viewer = shinygadgets::dialogViewer("RCleaner"))
  
  #code to select and remove rows was modified from the following:
  #https://stackoverflow.com/questions/39136385/delete-row-of-dt-data-table-in-shiny-app
}
