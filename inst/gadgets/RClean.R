library(shiny)
library(miniUI)
library(ggplot2)
library(DT)

RCleaner <- function(data, ...) {
  
  ui <- miniPage(
    gadgetTitleBar("RClean - Interactive Data Cleaning"),
    miniContentPanel(
      DT::dataTableOutput("Main_table")
    )
  )
  
  server <- function(input, output, session) {

    output$Main_table <- DT::renderDataTable({data
    })
    
    # Handle the Done button being pressed.
    observeEvent(input$done, {
      # Return the brushed points. See ?shiny::brushedPoints.
      stopApp(brushedPoints(data, input$brush))
    })
  }
  
  runGadget(ui, server, viewer = dialogViewer("RCleaner"))
}