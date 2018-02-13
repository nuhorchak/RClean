#' @title RClean gadget
#'
#' @description interactive data cleaning
#'
#' @param data The data to be used - must be of type DF, tibble or matrix with 2 or more columns
#' @param theme Shiny theme used for output
#' @param ... additional arguments not specified
#'
#' @importFrom DT DTOutput renderDT
#' @import shiny
#' @importFrom pacman p_load p_load_gh
#' @import miniUI
#' @importFrom shinythemes shinytheme
#'
#' @export
RCleaner <- function(data, theme = 'united', ...) {
  
  #pacman function to load libraries
  pacman::p_load(shiny, DT)

  # ui <- miniUI::miniPage(
  #   gadgetTitleBar("RClean - Interactive Data Cleaning"),
  #   miniContentPanel(
  #     DT::DTOutput("Main_table")
  #   ),
  #   miniButtonBlock(actionButton("deleteRows", "Delete Rows"), actionButton("deleteCols", "Delete Cols"),
  #                   actionButton("center", "Mean Center Column"), actionButton("scale", "Scale Columns"))
  # )
  
  ui <- fluidPage(title = "RClean - Interactive Data Cleaning",
                  theme = shinythemes::shinytheme(theme = theme),
    titlePanel("RClean - Interactive Data Cleaning"),
    #create action buttons
    flowLayout(
      actionButton("deleteRows", "Delete Rows"),
      actionButton("deleteCols", "Delete Columns"),
      actionButton("center", "Mean Center Column"),
      actionButton("scale", "Scale Columns")
    ),
    fluidRow(
      DT::DTOutput("Main_table")
    ),
    fluidRow(
      column(width=1, offset=5,
             actionButton("done", "Done")),
      column(width=1, offset=0,
             actionButton("cancel","Cancel"))
    )
  )

  server <- function(input, output, session) {

    #create dataframe to manipulate
    values <- reactiveValues(dfWorking = data)
    
    ######################################
    #BOTTOM BUTTON LOGIC
    ### DELETE ROWS ### needs to handle deleting all rows
    #select rows to delete, unless no rows are selected 
    observeEvent(input$deleteRows, {
      if (!is.null(input$Main_table_rows_selected)) {
        values$dfWorking <- values$dfWorking[-as.numeric(input$Main_table_rows_selected),]
      } else {print("No rows selected")}
    })
    
    ### DELETE COLS ###
    #select cols to delete, unless no cols are selected 
    observeEvent(input$deleteCols, {
      if (!is.null(input$Main_table_columns_selected)) {
        values$dfWorking <- values$dfWorking[,-as.numeric(input$Main_table_columns_selected)]
      } else {print("No columns selected")}
    })
    
    observeEvent(input$center, {
      #if pointer is not null
      if (!is.null(input$Main_table_columns_selected)) {
        values$dfWorking <- 
          center_scale(c(input$Main_table_columns_selected), 
                       values$dfWorking, TRUE, FALSE)
      }else{print("No input selected")} #else pointer is null
    })
    
    observeEvent(input$scale, {
      #if pointer is not null
      if (!is.null(input$Main_table_columns_selected)) {
        values$dfWorking <- 
          center_scale(c(input$Main_table_columns_selected), 
                       values$dfWorking, FALSE, TRUE)
      }else{print("No input selected")} #else pointer is null
    })

    output$Main_table <- DT::renderDT(values$dfWorking, 
                                             server = TRUE, 
                                             selection = list(target = 'row+column'))
    
    ### TOP BUTTONS ###
    # Handle the Done button being pressed.
    observeEvent(input$done, {
      # Return the modified datatable
      #stopApp(indices <<- input$Main_table_columns_selected)
      stopApp(clean_data <<- data.frame(values$dfWorking))
      #stopApp(list(my_data = data.frame(values$dfWorking)))
    })
    
    #cancel logic - for some reason it stopped working
    observeEvent(input$cancel, {
      stopApp(print("User cancelled action"))
    })
    
  }

  #shinygadgets::runGadget(ui, server, viewer = shinygadgets::dialogViewer("RCleaner"))
  runGadget(app = ui,
            server = server,
            viewer = browserViewer(browser = getOption("browser")))
  
  #code to select and remove rows was modified from the following:
  #https://stackoverflow.com/questions/39136385/delete-row-of-dt-data-table-in-shiny-app
}
