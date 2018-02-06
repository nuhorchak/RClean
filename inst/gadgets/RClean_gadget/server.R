# server <- function(input, output, session){
#   output$table <- renderDataTable(iris,
#     options = list(
#     pageLength = 5
#   )
#   )
# }

server <- function(input, outout, session) {
  output$plot <- renderPlot(
    ggplot(data, aes_string(xvar, yvar)) + geom_point()
  )
  
  observeEvent(input$done, {
    stopApp(brushedPoints(data, input$brush))
  })
}