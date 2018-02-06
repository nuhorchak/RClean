server <- function(input, output, session){
  output$table <- renderDataTable(iris,
    options = list(
    pageLength = 5
  )
  )
}