#' RClean center and scale
#'
#' center and scale function to handle non-numeric data. checks for numeric data, applies scale() from base R
#'
#' @param indices the indices from the shiny gadget
#' @param DF the dataframe that is being worked on
#' @param center binary true/false for scale() function
#' @param scale binary true/false for scale() function
#'
center_scale <- function(indices, DF, center, scale){
  for (index in indices){
    if(is.numeric(DF[,index])){
      #print("data is numeric")
      DF[,index] <- scale(DF[,index, drop = FALSE], center=center, scale=scale)
    } else {print(paste("column", index, " is not numeric"))}
  }
  return(DF)
}