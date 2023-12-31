% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AuxFunctions.R
\name{xl_TEXT}
\alias{xl_TEXT}
\title{Convert an integer to text with leading zeroes  (Excel equivalent TEXT)}
\usage{
xl_TEXT(myValue, myFormat)
}
\arguments{
\item{myValue}{the vector containing integer values}

\item{myFormat}{a character used to indicate the character number of the string to be returned}
}
\value{
A vector with character strings
}
\description{
xl_TEXT evaluates an integer input value or vector and transforms it
to a text format with leading zeros.
The function is used to simplify parsing Excel formulas.
However only one of the different formats of the original Excel function is implemented.
}
\examples{
temp1 <- c (0, 1, 2, 3, 4)
xl_TEXT (temp1, "000")
# Result:  "000" "001" "002" "003" "004"

}
