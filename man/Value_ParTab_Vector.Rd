% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AuxFunctions.R
\name{Value_ParTab_Vector}
\alias{Value_ParTab_Vector}
\title{Provide a Vector of values from a parameter table}
\usage{
Value_ParTab_Vector(
  myParTab,
  myCode,
  myDataFieldName,
  myRoundDigits = 3,
  myCodeForNoComponent = "-",
  myValueForNoComponent = 0,
  myErrorValue = -99999
)
}
\arguments{
\item{myParTab}{the parameter table to be evaluated}

\item{myCode}{a character vector containing the IDs of the parameter sets (which row)}

\item{myDataFieldName}{a character vector containing the names of the parameters (which column)}

\item{myRoundDigits}{an optional integer indicating the number of digits for rounding a numerical result value}

\item{myCodeForNoComponent}{an optional code identifying a row of the parameter table
to be used when the requested parameter set is not existing}

\item{myValueForNoComponent}{an optional value used when the component is not existing}

\item{myErrorValue}{= an optional error value used when the element of the table cannot be identified}
}
\value{
A numerical or character vector
}
\description{
Value_ParTab_Vector provides a vector of values from a parameter table or dataframe.
The parameter table is containing parameter sets (rows) identified by their row name
and parameter values in further columns identified by the respective column names.
The elements to be provided are identified by row name and column name of the parameter table.
The row names and column names are both given by vectors of the same length (two columns of a dataframe = "project data").
}
\examples{

demo_partab_Uvalues <-
  as.data.frame ( rbind (
    c ("Roof", 1.2, 0.15),
    c ("Wall", 1.0, 0.18),
    c ("Window", 2.8, 1.0),
    c ("Floor", 0.8, 0.2)
  ))

colnames (demo_partab_Uvalues) <-
  c ("Element", "Old", "New")

rownames (demo_partab_Uvalues) <-
  demo_partab_Uvalues [ , 1]

demo_partab_Uvalues
## View:
#        Element Old  New
# Roof      Roof 1.2 0.15
# Wall      Wall   1 0.18
# Window  Window 2.8    1
# Floor    Floor 0.8  0.2

demo_projectdata <-
  as.data.frame (
    rbind (
      c ("A.01", "Roof",   "Old"),
      c ("A.02", "Floor",  "New"),
      c ("A.03", "Wall",   "Old"),
      c ("A.04", "Roof",   "Old"),
      c ("A.05", "Roof",   "New"),
      c ("A.06", "Window", "New"),
      c ("A.07", "Wall",   "Old")
    )
  )

colnames (demo_projectdata) <-
  c ("ID_Dataset", "Type", "Feature")

rownames (demo_projectdata) <-
  demo_projectdata [ , 1]

demo_projectdata
## View:
#      ID_Dataset   Type Feature
# A.01       A.01   Roof     Old
# A.02       A.02  Floor     New
# A.03       A.03   Wall     Old
# A.04       A.04   Roof     Old
# A.05       A.05   Roof     New
# A.06       A.06 Window     New
# A.07       A.07   Wall     Old

Value_ParTab_Vector (
  demo_partab_Uvalues,
  demo_projectdata$Type,
  demo_projectdata$Feature,
)

## Result:
# 1.20 0.20 1.00 1.20 0.15 1.00 1.00

}
