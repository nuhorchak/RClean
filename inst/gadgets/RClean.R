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
    
    # Render the plot
    #output$plot <- renderPlot({
      # Plot the data with x/y vars indicated by the caller.
      #ggplot(data, aes_string(xvar, yvar)) + geom_point()
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