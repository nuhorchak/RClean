
#' @title RClean
#'
#' @description Run as a shiny app
#' 
#' @param app_name character string for the directory of this package
#' @param ... additional options passed to shinyAppDir
#' 
#' @return a printed shiny app output
#' 
#' @examples #using example is a complete seperate document, use this
#' \dontrun{ run_my_app('my_first_app')}
#' 
#' @importFrom shiny shinyAppDir
#' 
#' @export
run_my_app <- function(app_name, ...){
  app_dir <- system.file('apps', app_name, package='RClean')
  
  shiny::shinyAppDir(appDir=app_dir, options = list(...))
}
