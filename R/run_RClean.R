
#' @title RClean
#'
#' @description Run as a shiny gadget
#' 
#' @param app_name character string for the directory of this package
#' @param ... additional options passed to shinyAppDir
#' 
#' @return a printed shiny app output
#' 
#' @examples #using example is a complete seperate document, use this
#' \dontrun{ run_RClean(mtcars, "hp", "mpg")}
#' 
#' @importFrom shiny shinyAppDir
#' 
#' @export
run_RClean <- function(data, xvar, yvar){
  runGadget("inst/gadgets/RClean_gadget/ui.R", "inst/gadgets/RClean_gadget/server.R", stopOnCancel = TRUE)
}

