
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
#' @importFrom shiny shiny_appdior
#' 
#' @export
run_my_gadget <- function(app_name, data, xvar, yvar, ...){
  app_dir <- system.file('gadgets', app_name, package='RClean')
  
  shiny::shinyAppDir(appDir=app_dir, options = list(...))
}

