#' RClean gadget
#'
#' Interactive data cleaning.  This gadget initializes a DF, matrix or tibble in a browser window for data cleaning.
#'
#' @param Data The data to be used - must be of type DF, tibble or matrix with 2 or more columns
#' @param theme Shiny theme used for output (default is united)
#' @param ... additional arguments
#' 
#' @return modified DF with changes applied from gadget
#'
#' @importFrom DT DTOutput renderDT
#' @import shiny
#@import #shinyjs 
#' @importFrom shinythemes shinytheme
#' @importFrom markdown markdownToHTML
#'
#' @export
RCleaner <- function(Data, theme = 'united', ...) {
  
  #close browser code
  #jscode <- "shinyjs.closeWindow = function() { window.close(); }"

  ui <- fluidPage(title = "RClean - Interactive Data Cleaning",
                  theme = shinythemes::shinytheme(theme = theme),
                 #shinyjs::useShinyjs(),
                 #shinyjs::extendShinyjs(text = jscode, functions = c("closeWindow")),
                  tags$body(
                    tags$style(HTML("
                      body {
                        max-width: none
                      }
                    "))
                  ),
                  
    titlePanel("RClean - Interactive Data Cleaning"),
    
    #build main panel with two tabs, instructions and gadget
    mainPanel(
      tabsetPanel(type = 'pills',
                  #instructions tab
                  tabPanel('Instructions', 
                           uiOutput('instructions', inline = TRUE),
                           actionButton("cancel_inst", "Cancel")),
                  #gadget tab
                  tabPanel('Data Manipulation',
                    #create action buttons
                      actionButton("deleteRows", "Delete Rows"),
                      actionButton("deleteCols", "Delete Columns"),
                      actionButton("center", "Mean Center Column"),
                      actionButton("scale", "Scale Columns"),
                    #display data
                    fluidRow(
                      DT::DTOutput("Main_table")
                    ),
                    #display close and cancel buttons
                    actionButton("close", "Finish and Close"),
                    actionButton("cancel","Cancel")
                  ),
                  tabPanel('Rename Columns',
                           sidebarLayout(
                             sidebarPanel(width = 3,
                                          hr(),
                                          selectInput("names", "Column Names",colnames(Data)),
                                          textInput("new_name", "New Column Name"),
                                          actionButton("save_name", "Save Name")),
                             mainPanel(
                               DT::DTOutput("Main_table_colnames")
                             )
                           ),
                           actionButton("close_rename", "Finish and Close"),
                           actionButton("cancel_rename","Cancel")
                  )
      )
    )
  )

  server <- function(input, output, session) {

    #create dataframe to manipulate with reactive values
    values <- reactiveValues(dfWorking = Data)
    
    #instructions
    output$instructions  <- renderUI({
      
      file = system.file('instructions.Rmd', package = "RClean")
      withMathJax(HTML(markdown::markdownToHTML(knitr::knit(file))))
    })
    
    ######################################
    #select rows to delete, unless no rows are selected 
    observeEvent(input$deleteRows, {
      #check to see if pointer is not null
      if (!is.null(input$Main_table_rows_selected)) {
        values$dfWorking <- values$dfWorking[-as.numeric(input$Main_table_rows_selected),]
      } else {print("No rows selected")}
    })
    
    ### DELETE COLS ###
    #select cols to delete, unless no cols are selected 
    observeEvent(input$deleteCols, {
      #check to see if pointer is not null
      if (!is.null(input$Main_table_columns_selected)) {
        values$dfWorking <- values$dfWorking[,-as.numeric(input$Main_table_columns_selected)]
      } else {print("No columns selected")}
    })
    
    ## MEAN CENTER COLUMNS ##
    observeEvent(input$center, {
      #if pointer is not null
      if (!is.null(input$Main_table_columns_selected)) {
        values$dfWorking <- 
          center_scale(c(input$Main_table_columns_selected), 
                       values$dfWorking, TRUE, FALSE)
      }else{print("No input selected")} #else pointer is null
    })
    
    ## SCALE COLUMNS ##
    observeEvent(input$scale, {
      #if pointer is not null
      if (!is.null(input$Main_table_columns_selected)) {
        values$dfWorking <- 
          center_scale(c(input$Main_table_columns_selected), 
                       values$dfWorking, FALSE, TRUE)
      }else{print("No input selected")} #else pointer is null
    })
    
    ## RENDER DT IN MANIPULATION TAB ##
    output$Main_table <- DT::renderDT(values$dfWorking, 
                                      server = TRUE, 
                                      selection = list(target = 'row+column'))
    ##################
    ## RENAME TAB LOGIC ##
    #dynamic update to variable names input for rename tab
    observe(
      updateSelectInput(session, "names",
                        choices = colnames(values$dfWorking))
    )
    
    ## RENDER DT IN RENAME TAB ##
    output$Main_table_colnames <- DT::renderDT(values$dfWorking, 
                                               server = TRUE)
    
    # Handle the save name button - rename columns
    observeEvent(input$save_name, {
      if (input$new_name == ""){
        print("No Variable Name Input")
      }else if (input$new_name %in% colnames(values$dfWorking)){
        print("Duplicate Variable Name")
      }else {
        colnames(values$dfWorking)[colnames(values$dfWorking) == input$names] <- input$new_name
      }
    })
    
    ### FINISH/CANCEL BUTTONS ###
    #cancel logic - instructions
    observeEvent(input$cancel_inst, {
      #js$closeWindow()
      stopApp(print("User cancelled action"))
    })
    
    # Handle the Finish and close button being pressed. - manipulation
    observeEvent(input$close, {
      #js$closeWindow()
      # Return the modified datatable
      stopApp(list(my_data = data.frame(values$dfWorking)))
    })
    
    #cancel logic - manipulation
    observeEvent(input$cancel, {
      #js$closeWindow()
      stopApp(print("User cancelled action"))
    })
    
    #cancel logic - rename columns
    observeEvent(input$cancel_rename, {
      #js$closeWindow()
      stopApp(print("User cancelled action"))
    })
    
    # Handle the Done button being pressed. - rename columns
    observeEvent(input$close_rename, {
      #js$closeWindow()
      # Return the modified datatable
      stopApp(list(my_data = data.frame(values$dfWorking)))
    })
    

    
  }

  runGadget(app = ui,
            server = server,
            viewer = browserViewer(browser = getOption("browser")))
  
  #code to select and remove rows was modified from the following:
  #https://stackoverflow.com/questions/39136385/delete-row-of-dt-data-table-in-shiny-app
  
  #code to close browser window modified from the following:
  #https://deanattali.com/blog/advanced-shiny-tips/
  
  #mean impute - test on air miles dataset
}
