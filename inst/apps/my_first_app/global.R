#put all calls for packages, datasets, ...so on go in this file
library(shiny)
library(shinythemes)
library(choroplethr)
library(choroplethrMaps)


#load the data set from the choroplethrMaps package
data('df_state_demographics')
map_data <- df_state_demographics 