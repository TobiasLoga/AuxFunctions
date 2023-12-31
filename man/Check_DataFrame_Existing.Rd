% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AuxFunctions.R
\name{Check_DataFrame_Existing}
\alias{Check_DataFrame_Existing}
\title{Check if a dataframe is existing}
\usage{
Check_DataFrame_Existing(myDataFrameName)
}
\arguments{
\item{myDataFrameName}{a character string indicating the name of the dataframe}
}
\value{
A boolean value
}
\description{
Check_DataFrame_Existing can be used to check if a dataframe is existing
before adding new vectors or assigning values.
}
\examples{

demo_dataframe_1 <- as.data.frame (
  x = c (101, 102, 103),
  row.names = c("row1", "row2", "row3")
  )
Check_DataFrame_Existing (
  myDataFrameName = "demo_dataframe_1"
  )
## Result: TRUE

demo_dataframe_1 <- NA
Check_DataFrame_Existing (
  myDataFrameName = "demo_dataframe_1"
  )
## Result: FALSE

library(clidamonger)
  Check_DataFrame_Existing (
   myDataFrameName = "data.ta.hd"
   )
Result: TRUE

#' detach("package:clidamonger", unload = TRUE)
  Check_DataFrame_Existing (
   myDataFrameName = "data.ta.hd"
   )
## Result: FALSE
}
