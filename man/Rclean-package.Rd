\name{Rclean-package}
\alias{Rclean-package}
\alias{Rclean}
\docType{package}
\title{
  RClean, An Interactive Data Cleaning Tool Provides Users The Dynamic Ability To Import And Clean Data
}
\description{
  This package attempts to replicate data cleaning functionality from Excel in R
}
\details{
  Utilizing R to import and clean data is often a time consuming task.  
        Without preparation of the dataset in excel or other software, R users must use scripts or 
        command line R code for this task.  The Interactive Data Cleaning tool will afford users 
        the ability to do the following: Visually inspect the previously imported data, 
        Select releveant data columns to retain/remove, Provide the ability to rename columns in the 
        dataframe, Select relevant data rows to retain/remove, Provide the option to scale the data, 
        Provide the option to mean center the data, Provide the ability to encode dummy variables, 
        Save the new data to a "cleaned" dataframe via the assignment operator, 
        Write the "clean" DF to excel document for future use.
}
\author{
Nicholas Uhorchak

Maintainer: Nicholas Uhorchak <nuhorchak@gmail.com>
}
\keyword{ data cleaning }
\examples{
  \dontrun{
     RCleaner(iris)  
  }
}
