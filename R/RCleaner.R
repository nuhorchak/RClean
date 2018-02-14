#' @title RClean gadget
#'
#' @description Interactive data cleaning.  This gadget initializes a DF, matrix or tibble in a browser window for data cleaning.
#'
#' @param data The data to be used - must be of type DF, tibble or matrix with 2 or more columns
#' @param theme Shiny theme used for output (default is united)
#' @param ... additional arguments not specified_gh
#'
#' @importFrom DT DTOutput renderDT
#' @import shiny
#' @importFrom pacman p_load p_load
#' @importFrom shinythemes shinytheme
#'
#' @export
RCleaner <- function(data, theme = 'united', ...) {
  
  #pacman function to load libraries
  pacman::p_load(shiny, DT, shinyjs)
  
  #close browser code
  jscode <- "shinyjs.closeWindow = function() { window.close(); }"

  ui <- fluidPage(title = "RClean - Interactive Data Cleaning",
                  theme = shinythemes::shinytheme(theme = theme),
                  includeCSS("inst/www/custom.css"),
                  useShinyjs(),
                  extendShinyjs(text = jscode, functions = c("closeWindow")),
                  
    titlePanel("RClean - Interactive Data Cleaning"),
    
    #build main panel with two tabs, instructions and gadget
    mainPanel(
      tabsetPanel(type = 'pills',
                  #instructions tab
                  tabPanel('Instructions', uiOutput('instructions', inline = TRUE)),
                  #gadget tab
                  tabPanel('RCleaner Gadget',
                    #create action buttons
                    flowLayout(
                      actionButton("deleteRows", "Delete Rows"),
                      actionButton("deleteCols", "Delete Columns"),
                      actionButton("center", "Mean Center Column"),
                      actionButton("scale", "Scale Columns")
                    ),
                    #display data
                    fluidRow(
                      DT::DTOutput("Main_table")
                    ),
                    #display close and cancel buttons
                    fluidRow(
                      column(width=1, offset=5,
                             actionButton("close", "Finish and Close")),
                      column(width=1, offset=1,
                             actionButton("cancel","Cancel"))
                    )
                  )
      )
    )
  )

  server <- function(input, output, session) {

    #create dataframe to manipulate with reactive values
    values <- reactiveValues(dfWorking = data)
    
    #instructions
    output$instructions  <- renderUI({
      
      file = system.file('instructions.Rmd', package = "RClean")
      withMathJax(HTML(markdown::markdownToHTML(knitr::knit(file))))
    })
    
    ######################################
    #BOTTOM BUTTON LOGIC
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
    observeEvent(input$close, {
      js$closeWindow()
      # Return the modified datatable
      #stopApp(clean_data <<- data.frame(values$dfWorking))
      stopApp(list(my_data = data.frame(values$dfWorking)))
    })
    
    #cancel logic 
    observeEvent(input$cancel, {
      js$closeWindow()
      stopApp(print("User cancelled action"))
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
