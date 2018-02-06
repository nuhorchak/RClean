# ui <- miniPage(
#   gadgetTitleBar("RClean - Interactive Data Cleaning Tool"),
#   miniContentPanel(
#     #this is where i will define what the user interface does
#     
#   )
# )

ui <- miniPage(
  gadgetTitleBar("Drag to select points"),
  miniContentPanel(
    #the brush = "brush" argument means we listen for
    # brush events on the plot using input$brush
    plotOutput("plot",height="100%", brush = "brush")
  )
)