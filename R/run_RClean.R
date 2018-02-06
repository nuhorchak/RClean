
#' @title RClean
#'
#' @description Run as a shiny gadget
#' 
#' @param data dataset to use
#' @param xvar x variable to plot
#' @param yvar y variable to plot
#' 
#' @return a shiny gadget output
#' 
#' @examples #using example is a complete seperate document, use this
#' \dontrun{ run_RClean(mtcars, "hp", "mpg")}
#' 
#' 
#' @export
run_RClean <- function(data, xvar, yvar){
  runGadget("inst/gadgets/RClean_gadget/ui.R", "inst/gadgets/RClean_gadget/server.R", stopOnCancel = TRUE)
}

