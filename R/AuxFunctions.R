#####################################################################################################X
## User-defined auxiliary functions -----------------------------------------------------------------
#####################################################################################################X

#. ---------------------------------------------------------------------------------------------


## TimeStampForFileName
#' Time stamp for filename (current date and time)
#'
#' TimeStampForFileName creates a string from current date and time in a format usable as a file name.
#'
#' @param (none) no input
#' @return a string containing separators "-" and "_"
#' @examples
#' TimeStampForFileName ()
#' @export
TimeStampForFileName <- function()  {
  format(Sys.time(), "%Y-%m-%d_%H-%M-%S")
}

## TimeStampForDataset
#' Time stamp for dataset (current date and time)
#'
#' TimeStampForDataset creates a string from current date and time in a standard date-time format.
#'
#' @param (None) No input
#' @return A string containing separators "-", " " and ":"
#' @examples
#' TimeStampForDataset ()
#' @export
TimeStampForDataset <- function()  {
  format(Sys.time(), "%Y-%m-%d %H:%M:%S")
}


## Replace_NA
#' Replace NA (Excel equivalent IFERROR)
#'
#' Replace_NA replaces NA or Inf by a value or a string.
#' The function is used to simplify parsing Excel formulas
#'
#' @param  myValue the vector with values to be checked
#' @param  ReturnIfNA the output value to be used in case of NA
#'
#' @return the input vector with NA values converted
#' @examples
#' temp1 <- c (1, 2, 3, NA, 5, 6)
#' Replace_NA (myValue = temp1, ReturnIfNA = "MissingValue")
#' ## Result: "1"            "2"            "3"            "MissingValue" "5"            "6"
#' @export
Replace_NA <- function (myValue, ReturnIfNA) {
  return (ifelse (is.na (myValue) | is.null(myValue) | is.infinite(myValue),
                  ReturnIfNA, myValue))
}


## Replace_NULL
#' Replace NULL (replace not existing element of a dataframe)
#'
#' Replace_NULL can be used in an operation on an element of a dataframe, that might not yet be existing,
#' and thus can help to avoid a result NULL.
#' NULL might be replaced by a value, a string or by NA.
#' An existing element or vector will not be changed.
#'
#' @param myValue the variable of a dataframe that might not yet exist
#' @param ReturnIfNA the output value to be used in case of NULL
#' @return the input vector if existing or the ReturnIfNA value if not existing
#' @examples
#' temp1 <- as.data.frame (c ("a", "b", "c", "d"))
#'
#' colnames (temp1) <- "Letters"
#'
#' Replace_NULL (temp1$Letters, NA)
#' ## Result: "a" "b" "c" "d"
#'
#' Replace_NULL (temp1$Numbers, NA)
#' ## Result: NA
#'
#' paste0 (temp1$Letters, Replace_NULL (temp1$Numbers, 0))
#' ## Result: "a0" "b0" "c0" "d0"
#'
#' Replace_NA (1/0, NA)
#' ## Result NA
#'
#' @export
Replace_NULL <- function (myValue, ReturnIfNULL) {
  if (is.null (myValue)) {
    myValue <- ReturnIfNULL
  }
  return (myValue)
}

## Reformat_InputData_Boolean
#' Reformat input data to 0/1-boolean
#'
#' Reformat_InputData_Boolean converts TRUE and "1" to 1 as well as FALSE and "0" to 0
#'
#' @param myIndicator a vector with strings, numbers or boolean
#' @return the integer values 1 or 0
#' @examples
#' temp1 <- c (FALSE, TRUE, "0", "1", 0, 1, "Anything", 137, NA)
#' Reformat_InputData_Boolean (myIndicator = temp1)
#' ## Result:  0  1  0  1  0  1 NA NA NA
#' @export
Reformat_InputData_Boolean <- function (myIndicator){
  return (ifelse (myIndicator == "0" | myIndicator == "FALSE", 0,
                  ifelse (myIndicator == "1" | myIndicator == "TRUE", 1, NA))
  )
}


## Format_Integer_LeadingZeros
#' Reformat integers to strings with leading zeroes
#'
#' Format_Integer_LeadingZeros converts a number or a vector of numbers to a character format
#' with leading zeros. Optionally prefixes
#'
#' @param myInteger a vector with numerical values
#' @param myWidth   a numerical value, indicating the width of the transformed number
#' (number of digits)
#' @param myPrefix  an optional character value or vector of the same length as myInteger
#' @param mySuffix  an optional character value or vector of the same length as myInteger
#' @return a vector of character strings
#' @examples
#' demovector_values <- c (1, 2, 3, 4, 5)
#' demo_prefix <- "ID."
#' demo_suffix <- ".TA"
#' Format_Integer_LeadingZeros (
#'   myInteger = demovector_values,
#'   myWidth   = 4,
#'   myPrefix  = demo_prefix,
#'   mySuffix  = demo_suffix
#' )
#' ## Result:  "ID.0001.TA" "ID.0002.TA" "ID.0003.TA" "ID.0004.TA" "ID.0005.TA"
#' @export
Format_Integer_LeadingZeros <- function (
    myInteger,
    myWidth = 2,
    myPrefix = "",
    mySuffix = ""
    ) {
  paste0 (
    myPrefix,
    formatC (myInteger, width = myWidth, format = "d", flag = "0"),
    mySuffix
  )
}


## Format_Numeric_Percentage
#' Reformat integers to strings in a percentage format
#'
#' Format_Numeric_Percentage converts a number or a vector of numbers to character strings
#' with percentage format.
#'
#' @param myNumeric a vector with numerical values
#' @param myDigits  a numerical value, indicating the decimal places
#' @param myReplacementNA  an optional value to be provided when the input is NA
#' @return a vector of character strings
#' @examples
#' demovector_1 <- c (0.11, 0.82, 0.987654, 0.5, 0.51, NA)
#' Format_Numeric_Percentage (
#'   myNumeric  = demovector_1,
#'   myDigits   = 1,
#'   myReplacementNA = -9999
#' )
#' ## Result:  "11.0 %"    "82.0 %"    "98.8 %"    "50.0 %"    "51.0 %"    "-9999.0 %"
#' @export
Format_Numeric_Percentage <- function (
    myNumeric,
    myDigits = 0,
    myReplacementNA = 0) {
  sprintf (paste0 ("%.",
                   myDigits,
                   "f %%"),
           Replace_NA (
             myNumeric * 100,
             myReplacementNA
           )
  )
}


#. ---------------------------------------------------------------------------------------------


## xl_LEFT
#' Left side of strings (Excel equivalent LEFT)
#'
#' xl_LEFT provides the left side of character strings in a vector, consisting of an indicated number of characters.
#' The function is used to simplify parsing Excel formulas
#'
#' @param myString a string or a vector of strings to be evaluated
#' @param i_Char_LeftSide the number of characters to be provided
#'
#' @return a string or a vector of strings consisting of the defined section of the input
#'
#' @examples
#' temp1 <- c ("sixty", "sixty one", "sixty two", "sixty three")
#' xl_LEFT (temp1, 3)
#' ## Result: "six" "six" "six" "six"
#'
#' @export
xl_LEFT <- function (myString, i_Char_LeftSide) {
  return (substr (myString, 1, i_Char_LeftSide))
}


## xl_RIGHT
#' Right side of strings (Excel equivalent RIGHT)
#'
#' xl_RIGHT provides the right side of character strings in a vector, consisting of an indicated number of characters.
#' The function is used to simplify parsing Excel formulas
#'
#' @param myString a string or a vector of strings to be evaluated
#' @param i_Char_RightSide the number of characters to be provided
#'
#' @return A string or a vector of strings consisting of the defined section of the input
#'
#' @examples
#' temp1 <- c ("2000", "2001", "2002", "2003", "2004")
#' xl_RIGHT (temp1, 2)
#' ## Result: "00" "01" "02" "03" "04"
#'
#' @export
xl_RIGHT <- function (
    myString,
    i_Char_RightSide
    ) {
  n_Char_myString <- nchar (myString)
  return (substr (myString, n_Char_myString - i_Char_RightSide + 1, n_Char_myString ))
}

## XL_MID ()
#' Middle section of strings  (Excel equivalent MID)
#'
#' xl_MID provides the middle section of character strings in a vector, starting from a specific position
#' and consisting of an indicated number of characters.
#' The function is used to simplify parsing Excel formulas
#' German Excel syntax: "TEIL ()"
#'
#' @param myString a string or a vector of strings to be evaluated
#' @param myCharIndex_Start the position to start the section
#' @param myCharCount the number of characters to be provided
#'
#' @return A string or a vector of strings consisting of the defined section of the input
#'
#' @examples
#' temp1 <- c ("2000-01-01 00:00", "2000-01-02 00:00", "2000-01-03 00:00", "2000-01-04 00:00", "2000-01-05 00:00")
#' xl_MID (temp1, 9, 2)
#' ## Result: "01" "02" "03" "04" "05"
#'
#' @export
xl_MID <- function (
    myString,
    myCharIndex_Start,
    myCharCount
    ) {
  return (substr (myString, myCharIndex_Start, myCharIndex_Start + myCharCount - 1))
}


## XL_FIND ()
#' Middle section of strings (Excel equivalent MID)
#'
#' xl_FIND provides the position of a of character strings in a vector, starting from a specific position
#' and consisting of an indicated number of characters.
#' The function is used to simplify parsing Excel formulas
#'
#' @param myPattern the character string to be found
#' @param myText a string or a vector of strings to be evaluated
#' @param myCharIndex_Start the position in the strings to start the search
#'
#' @return a number or a vector of numbers giving the position in the string.
#' If the pattern is not found, the value -1 will be returned
#'
#' @examples
#' temp1 <- c ("2000-01-01 00:00", "2000-01-02 00:00", "2000-01-03 00:00", "2000-01-04 00:00", "2000-01-05 00:00")
#' xl_FIND (myPattern = "04", temp1, 1)
#' ## Result: -1 -1 -1  9 -1
#'
#' DF_Test <- as.data.frame (c("Test234",
#'                             "alskjfa34_kl",
#'                             "Test"),
#'                           row.names = c("Row1", "Row2", "Row3"))
#' colnames (DF_Test) <- "Text"
#' DF_Test$Pattern <-  c("34", "skj", "est")
#' DF_Test
#' # printed dataframe "DF_Test":
#' #              Text Pattern
#' # Row1      Test234      34
#' # Row2 alskjfa34_kl     skj
#' # Row3         Test     est
#' xl_FIND (DF_Test$Pattern, DF_Test$Text, 1)
#' # Result: 6 3 2
#'
#' @export
xl_FIND <- function (
    myPattern,
    myText,
    myCharIndex_Start = 1
    ) {

  # Assign to dataframe
  myDF <- as.data.frame (myText)
  colnames (myDF) <- "Text"
  myDF$Patern <- myPattern
  myCharIndex_Result <- NA

  #Test of loop
  #i_Row <- 1
  for (i_Row in (1 : length (myText))) {
    myCharIndex_Result [i_Row] <-
    unlist (
      gregexpr (
        myDF$Patern [i_Row],
        xl_RIGHT (
          myDF$Text [i_Row],
          nchar (myDF$Text [i_Row]) - myCharIndex_Start + 1
        )
      )
    ) [1]
  } # End of loop

  return (
    myCharIndex_Result
  )
} # End of function

## old version, later to be deleted
# xl_FIND <- function (myPattern, myText, myCharIndex_Start = 1) {
#   # Test
#   # myPattern <- "est"
#   # myText <- "Test234"
#   # myCharIndex_Start <- 1
#   return (
#     unlist (
#       gregexpr (
#         myPattern,
#         xl_RIGHT (
#           myText,
#           nchar (myText) - myCharIndex_Start + 1
#           )
#         )
#       ) [1]
#     )
# }


## XL_AND ()
#' Logical AND (Excel equivalent AND)
#'
#' xl_AND evaluates boolean values or vectors of boolean values
#' 0 and FALSE as well as 1 and TRUE are treated in the same way.
#' The function is used to simplify parsing Excel formulas.
#'
#' @param myVector_1 the first vector containing boolean values
#' @param myVector_2 the second vector containing boolean values, same length as myVector_1
#' @param myVector_3 an optional third vector containing boolean values, same length as myVector_1
#' @param myVector_4 an optional fourth vector containing boolean values, same length as myVector_1
#'
#' @return a vector with boolean values
#'
#' @examples
#' temp1 <- c (TRUE, TRUE, FALSE, FALSE, TRUE)
#' temp2 <- c (TRUE, FALSE, TRUE, FALSE, TRUE)
#' temp3 <- c (0, 1, 0, 0, 1)
#' xl_AND (temp1, temp2, temp3)
#' # Result: FALSE FALSE FALSE FALSE  TRUE
#' @export
xl_AND <- function (
    MyVector_1,
    MyVector_2,
    MyVector_3 = TRUE,
    MyVector_4 = TRUE) {
  return (MyVector_1 &
            MyVector_2 &
            MyVector_3 &
            MyVector_4)
}

## Old version, later to be deleted
# xl_AND_2 <- function (MyVector_1, MyVector_2) {
#     return (MyVector_1 & MyVector_2)
# }
#
# xl_AND_3 <- function (MyVector_1, MyVector_2, MyVector_3) {
#     return (MyVector_1 & MyVector_2 & MyVector_3)
# }
#
# xl_AND_4 <- function (MyVector_1, MyVector_2, MyVector_3, MyVector_4) {
#     return (MyVector_1 & MyVector_2 & MyVector_3 & MyVector_4)
# }


## XL_OR ()
#' Logical OR (Excel equivalent OR)
#'
#' xl_OR evaluates boolean values or vectors of boolean values
#' 0 and FALSE as well as 1 and TRUE are treated in the same way.
#' The function is used to simplify parsing Excel formulas
#'
#' @param myVector_1 the first vector containing boolean values
#' @param myVector_2 the second vector containing boolean values, same length as myVector_1
#' @param myVector_3 an optional third vector containing boolean values, same length as myVector_1
#' @param myVector_4 an optional fourth vector containing boolean values, same length as myVector_1
#'
#' @return a vector with boolean values
#'
#' @examples
#' temp1 <- c (TRUE, TRUE, FALSE, FALSE, TRUE)
#' temp2 <- c (TRUE, FALSE, TRUE, FALSE, TRUE)
#' temp3 <- c (0, 1, 0, 0, 1)
#' xl_OR (temp1, temp2, temp3)
#' # Result:  TRUE  TRUE  TRUE FALSE  TRUE
#' @export
xl_OR <- function (
    myVector_1,
    myVector_2,
    myVector_3=FALSE,
    myVector_4=FALSE) {
  return (myVector_1 | myVector_2 | myVector_3 | myVector_4)
}

## old version, later to be deleted
# xl_OR_2 <- function (myVector_1, myVector_2) {
#     return (myVector_1 | myVector_2)
# }
#
# xl_OR_3 <- function (myVector_1, myVector_2, myVector_3) {
#     return (myVector_1 | myVector_2 | myVector_3)
# }
#
# xl_OR_4 <- function (myVector_1, myVector_2, myVector_3, myVector_4) {
#     return (myVector_1 | myVector_2 | myVector_3 | myVector_4)
# }



## XL_NOT ()
#' Logical NOT (Excel equivalent NOT)
#'
#' xl_OR evaluates a boolean value or a vector of boolean values
#' 0 and FALSE as well as 1 and TRUE are treated in the same way.
#' The function is used to simplify parsing Excel formulas
#'
#' @param myVector the vector containing boolean values
#'
#' @return a vector with boolean values
#'
#' @examples
#' temp1 <- c (TRUE, TRUE, FALSE, FALSE, TRUE)
#' xl_NOT (temp1)
#' # Result: FALSE FALSE  TRUE  TRUE FALSE
#'
#' temp2 <- c (0, 1, 0, 0, 1)
#' xl_NOT (temp2)
#' # Result:  TRUE FALSE  TRUE  TRUE FALSE
#'
#' @export
xl_NOT <- function (
    myVector
    ) {
  return (! myVector)
}



## XL_TEXT ()
#' Convert an integer to text with leading zeroes  (Excel equivalent TEXT)
#'
#' xl_TEXT evaluates an integer input value or vector and transforms it
#' to a text format with leading zeros.
#' The function is used to simplify parsing Excel formulas.
#' However only one of the different formats of the original Excel function is implemented.
#'
#' @param myValue the vector containing integer values
#' @param myFormat a character used to indicate the character number of the string to be returned
#'
#' @return A vector with character strings
#'
#' @examples
#' temp1 <- c (0, 1, 2, 3, 4)
#' xl_TEXT (temp1, "000")
#' # Result:  "000" "001" "002" "003" "004"
#'
#' @export
xl_TEXT <- function (myValue, myFormat)  {
  myWidth <- nchar (myFormat)
  return (
    formatC (
      as.numeric (myValue),
      width = myWidth,
      format = "d",
      flag = "0"
    )
  )
}


## XL_DATE ()
#' Provide date format from year, month and day integers  (Excel equivalent DATE)
#'
#' @description  xl_DATE evaluates integer vectors containing numerical information about year, month and day
#' and provides a vector of dates in the format YYYY-MM-DD.
#' The function is used to simplify parsing Excel formulas and apply it to vector variables.
#'
#' @param myVector_01 the first vector containing numeric values
#' @param myVector_02 the second vector containing numeric values
#' @param myVector_03 to myVector_10 optional the first vector containing numeric values
#'
#' @return a vector with character strings in date format
#'
#' @examples
#' temp_year  <- c (2020, 2021, 2021, 2022)
#' temp_month <- c (12, 1, 12, 1)
#' temp_day   <- c (31, 1, 31, 1)
#' xl_DATE (temp_year, temp_month, temp_day)
#' # Result:   "2020-12-31" "2021-01-01" "2021-12-31" "2022-01-01"
#'
#' @export
xl_DATE <- function (
    myYear = 1900,
    myMonth = 1,
    myDay = 1)  {

  # Test
  # myYear <- 2022
  # myMonth <- 13
  # myDay <- 1

  myYear  <- Replace_NA (myYear,  1900)
  myMonth <- Replace_NA (myMonth, 1)
  myDay   <- Replace_NA (myDay,   1)

  myYear <-
    myYear +
    ((myMonth - 1) %/% 12)

  myMonth <-
    ((myMonth - 1) %% 12) + 1

  myDate <-
    as.Date (paste0 (
      myYear,
      "-",
      Format_Integer_LeadingZeros(myMonth, 2),
      "-",
      Format_Integer_LeadingZeros(myDay, 2)
    ))

  return (myDate)

}


## xl_EOMONTH ()
#' Provide the last day of months  (Excel equivalent EOMONTH)
#'
#' @description xl_EOMONTH evaluates a vector with dates and provides for each date
#' the last day of the given month. In addition an integer number can be used to add
#' a certain number months to the given dates.
#' The function is used to simplify parsing Excel formulas and apply it to vector variables.
#'
#' @param myDate       a value or a vector containing the date
#' @param myAddMonths  a value or a vector containing the number of additional months
#'
#' @return a vector with character strings in date format
#'
#' @examples
#'
#' temp_date_1  <- c ("2020-01-01", "2021-01-01", "2022-01-01", "2023-01-01", "2024-01-01")
#' xl_EOMONTH (temp_date_1, 0)
#' # Result: "2020-01-31" "2021-01-31" "2022-01-31" "2023-01-31" "2024-01-31"
#' xl_EOMONTH (temp_date_1, 1)
#' # Result: "2020-02-29" "2021-02-28" "2022-02-28" "2023-02-28" "2024-02-29"
#' temp_date_2  <- "1999-12-31"
#' temp_add_months <- c (2, 12+2, 2*12+2, 3*12+2, 4*12+2, 5*12+2)
#' xl_EOMONTH (temp_date_2, temp_add_months)
#' # Result: "2000-02-29" "2001-02-28" "2002-02-28" "2003-02-28" "2004-02-29" "2005-02-28"
#'
#' @export
xl_EOMONTH <- function (
    myDate = "1900-01-01",
    myAddMonths = 0
    )  {

  myYear  <- as.integer (substring (myDate, 1, 4))
  myMonth <- as.integer (substring (myDate, 6, 7))
  myDay   <- as.integer (substring (myDate, 9, 10))

  return (
    xl_DATE (myYear, myMonth + 1 + myAddMonths, 1) - 1
  )

}


## xl_CONCATENATE
#' @title   Concatenate vectors of character strings by row (Excel equivalent CONCATENATE)
#'
#' @description   xl_CONCATENATE concatenates vectors of character strings by row.
#' The function is used to simplify parsing Excel formulas and to apply them to vector variables.
#'
#' @param ... one or more R objects, to be converted to character vectors.
#'
#' @return A character vector of the concatenated values.
#'
#' @examples
#' temp1 <- c ("cow ", "pig ", "elephant ", "tiger ")
#' temp2 <- c ("eats ", "loves ", "grows ", "has ")
#' temp3 <- c ("grass", "mud", "big", "stripes")
#' xl_CONCATENATE (temp1, temp2, temp3)
#' # Result: "cow eats grass"     "pig loves mud"      "elephant grows big" "tiger has has "
#
#' @export
xl_CONCATENATE <- base::paste0


## %xl_JoinStrings%
#' Concatenate vectors of character strings by row (Excel equivalent operator &)
#'
#' %xl_JoinStrings% concatenates vectors of character strings by row.
#' The function is used to simplify parsing Excel formulas and to apply them to vector variables.
#' Definition of infix operators: https://www.datamentor.io/r-programming/infix-operator/
#'
#' @param myStr1 first vector of character strings.
#' @param myStr2 second vector of character strings.
#'
#' @return A character vector of the concatenated values.
#'
#' @examples
#' temp1 <- c ("cow ", "pig ", "elephant ", "tiger ")
#' temp2 <- c ("eats ", "loves ", "grows ", "has ")
#' temp3 <- c ("grass", "mud", "big", "stripes")
#' temp1 %xl_JoinStrings% temp2 %xl_JoinStrings% temp3
#' # Result: "cow eats grass"     "pig loves mud"      "elephant grows big" "tiger has has "
#'
#' @export
`%xl_JoinStrings%` <- function (
    myStr1,
    myStr2
    ) {
  return (
    paste0 (myStr1, myStr2)
  )
}


## XL_AVERAGE ()
#' Average vectors by row  (Excel equivalent AVERAGE)
#'
#' xl_AVERAGE evaluates numeric vectors and
#' provides a vector of mean values of the same length as the input vectors.
#' The function is used to simplify parsing Excel formulas and apply it to vector variables.
#'
#' @param myVector_01 the first vector containing numeric values
#' @param myVector_02 the second vector containing numeric values
#' @param myVector_03 to myVector_10 optional further vectors containing numeric values
#'
#' @return a vector with character strings
#'
#' @examples
#' temp1 <- c (0, 1, 2, 3, 4)
#' temp2 <- c (0.5, 1.5, 2.5, 3.5, 4.5)
#' xl_AVERAGE (temp1, temp2)
#' # Result:  "000" "001" "002" "003" "004"
#'
#' @export
xl_AVERAGE <-
  function (myVector_01,
            myVector_02,
            myVector_03 = NA,
            myVector_04 = NA,
            myVector_05 = NA,
            myVector_06 = NA,
            myVector_07 = NA,
            myVector_08 = NA,
            myVector_09 = NA,
            myVector_10 = NA) {

    return (
      apply (
        cbind (myVector_01,
               myVector_02,
               myVector_03,
               myVector_04,
               myVector_05,
               myVector_06,
               myVector_07,
               myVector_08,
               myVector_09,
               myVector_10),
        1,
        mean, na.rm=TRUE
      )
    )
  }




## xl_SUMPRODUCT ()
#' Sum of the elements of a vector product (Excel equivalent SUMPRODUCT)
#'
#' xl_SUMPRODUCT evaluates numeric vectors of the same length by multiplying
#' the elements of different vectors row by row and summing up the result vector
#' The function is used to simplify parsing Excel formulas and apply it to vector variables.
#'
#' @param myVector_01 the first vector containing numeric values
#' @param myVector_02 the second vector containing numeric values
#' @param myVector_03 to myVector_10 optional: further vectors containing numeric values
#'
#' @return A numerical value
#'
#' @examples
#' temp1 <- c (0, 1, 2, 3, 4)
#' temp2 <- c (0, 1, 2, 3, 4)
#' temp3 <- c (0, 1, 2, 3, 4)
#' xl_SUMPRODUCT (temp1, temp2, temp3)
#' ## Result:  100
#'
#' @export
xl_SUMPRODUCT <-
  function (myVector_01,
            myVector_02,
            myVector_03 = NA,
            myVector_04 = NA,
            myVector_05 = NA,
            myVector_06 = NA,
            myVector_07 = NA,
            myVector_08 = NA,
            myVector_09 = NA,
            myVector_10 = NA) {

    return (
      sum (
        apply (
          cbind.data.frame (myVector_01,
                 myVector_02,
                 myVector_03,
                 myVector_04,
                 myVector_05,
                 myVector_06,
                 myVector_07,
                 myVector_08,
                 myVector_09,
                 myVector_10),
          1,
          prod, na.rm=TRUE
        ),
        na.rm=TRUE
      )

    )
  }





#. ---------------------------------------------------------------------------------------------



## Value_ParTab ()
#' Provide a value from a parameter table
#'
#' Value_ParTab provides a value from a table or dataframe identified by the row name and the column name.
#'
#' @param myParTab the table to be evaluated
#' @param myCode a character string identifying the parameter ID = first column of the parameter table
#' @param myDataFieldName a character string identifying the datafield name (variable name)
#' = first row of the parameter table
#' @param myRoundDigits an optional integer indicating the number of digits for rounding the result value
#' @param myCodeForNoComponent an optional code identifying a row of the parameter table
#' to be used when the component is not existing
#' @param myValueForNoComponent an optional value used when the component is not existing
#' @param myErrorValue = an optional error value used when the element of the table cannot be identified
#'
#' @return A numerical or string value
#'
#' @examples
#' temp_StationName <-
#'   Value_ParTab (
#'     myParTab = clidamonger::data.ta.hd,
#'     myCode = "DE.MET.000917.TA_12",
#'     myDataFieldName = "Name_Station",
#'     myCodeForNoComponent = "-",
#'   )
#' temp_StationName
#' ## Result: "Darmstadt"
#'
#' temp_TA_12_M_2021_12 <-
#'   Value_ParTab (
#'     myParTab = clidamonger::data.ta.hd,
#'     myCode = "DE.MET.000917.TA_12",
#'     myDataFieldName = "M_2021_12",
#'     myRoundDigits = 1,
#'     myCodeForNoComponent = "-",
#'     myValueForNoComponent = -99,
#'     myErrorValue = -99
#'   )
#' temp_TA_12_M_2021_12
#  ## Result: 3.7
#
#' @export
Value_ParTab <-
  function (
    myParTab,
    myCode,
    myDataFieldName,
    myRoundDigits = 10,
    myCodeForNoComponent = "-",
    myValueForNoComponent = 0,
    myErrorValue = -99999
  ) {
    Result_Temp <-
      myParTab [
        cbind (
          ifelse (myCode %in% rownames (myParTab), myCode, NA),
          ifelse (myDataFieldName %in% colnames (myParTab), myDataFieldName, NA)
        )]
    # print (myRoundDigits)
    # print (ifelse (myCode %in% rownames (myParTab), myCode, NA))
    # print (ifelse (myDataFieldName %in% colnames (myParTab), myDataFieldName, NA))
    Result_Temp <- Replace_NA (
      ifelse (
        myCode == myCodeForNoComponent,
        myValueForNoComponent,
        Result_Temp),
      myErrorValue
    )
      #print (Result_Temp)
    Indicator_Numeric <- min (1 * !is.na (as.numeric (Result_Temp)))
      #print (Indicator_Numeric)
    Result_Numeric <- round (as.numeric (Result_Temp), myRoundDigits)
      #print (Result_Numeric)
    Result <- if (Indicator_Numeric == 1) {
      Result_Numeric
    } else {
      Result_Temp
    }
    return (Result)
  }



## String_ParTab ()
#' Provide a character string from a parameter table
#'
#' String_ParTab provides a character string from a table or dataframe identified by the row name and the column name.
#' The function is similar to Value_ParTab but adapted to provide character strings instead of numerical values.
#'
#' @param myParTab the table to be evaluated
#' @param myCode a character string identifying the parameter ID = first column of the parameter table
#' @param myDataFieldName a character string identifying the datafield name (variable name)
#' = first row of the parameter table
#' @param myCodeForNoComponent an optional code identifying a row of the parameter table
#' to be used when the component is not existing
#' @param myValueForNoComponent an optional string used when the component is not existing
#' @param myErrorValue = an optional error string used when the element of the table cannot be identified
#'
#' @return A character string
#'
#' @examples
#' temp_StationName <-
#'   String_ParTab (
#'     myParTab = clidamonger::data.ta.hd,
#'     myCode = "DE.MET.000917.TA_12",
#'     myDataFieldName = "Name_Station",
#'     myCodeForNoComponent = "-",
#'   )
#' temp_StationName
#' ## Result: "Darmstadt"
#'
#' @export
String_ParTab <-
  function (
    myParTab,
    myCode,
    myDataFieldName,
    myCodeForNoComponent = "-",
    myValueForNoComponent = "",
    myErrorValue = "_ERROR_"
  ) {
    return (Replace_NA (
      ifelse (
        myCode == myCodeForNoComponent,
        myValueForNoComponent,
        myParTab [myCode, myDataFieldName]
      )
      ,
      myErrorValue
    ))
  }



## Value_ParTab_Vector ()
#' Provide a Vector of values from a parameter table
#'
#' Value_ParTab_Vector provides a vector of values from a parameter table or dataframe.
#' The parameter table is containing parameter sets (rows) identified by their row name
#' and parameter values in further columns identified by the respective column names.
#' The elements to be provided are identified by row name and column name of the parameter table.
#' The row names and column names are both given by vectors of the same length (two columns of a dataframe = "project data").
#'
#' @param myParTab the parameter table to be evaluated
#' @param myCode a character vector containing the IDs of the parameter sets (which row)
#' @param myDataFieldName a character vector containing the names of the parameters (which column)
#' @param myRoundDigits an optional integer indicating the number of digits for rounding a numerical result value
#' @param myCodeForNoComponent an optional code identifying a row of the parameter table
#' to be used when the requested parameter set is not existing
#' @param myValueForNoComponent an optional value used when the component is not existing
#' @param myErrorValue = an optional error value used when the element of the table cannot be identified
#'
#' @return A numerical or character vector
#'
#' @examples
#'
#' demo_partab_Uvalues <-
#'   as.data.frame ( rbind (
#'     c ("Roof", 1.2, 0.15),
#'     c ("Wall", 1.0, 0.18),
#'     c ("Window", 2.8, 1.0),
#'     c ("Floor", 0.8, 0.2)
#'   ))
#'
#' colnames (demo_partab_Uvalues) <-
#'   c ("Element", "Old", "New")
#'
#' rownames (demo_partab_Uvalues) <-
#'   demo_partab_Uvalues [ , 1]
#'
#' demo_partab_Uvalues
#' ## View:
#' #        Element Old  New
#' # Roof      Roof 1.2 0.15
#' # Wall      Wall   1 0.18
#' # Window  Window 2.8    1
#' # Floor    Floor 0.8  0.2
#'
#' demo_projectdata <-
#'   as.data.frame (
#'     rbind (
#'       c ("A.01", "Roof",   "Old"),
#'       c ("A.02", "Floor",  "New"),
#'       c ("A.03", "Wall",   "Old"),
#'       c ("A.04", "Roof",   "Old"),
#'       c ("A.05", "Roof",   "New"),
#'       c ("A.06", "Window", "New"),
#'       c ("A.07", "Wall",   "Old")
#'     )
#'   )
#'
#' colnames (demo_projectdata) <-
#'   c ("ID_Dataset", "Type", "Feature")
#'
#' rownames (demo_projectdata) <-
#'   demo_projectdata [ , 1]
#'
#'demo_projectdata
#' ## View:
#' #      ID_Dataset   Type Feature
#' # A.01       A.01   Roof     Old
#' # A.02       A.02  Floor     New
#' # A.03       A.03   Wall     Old
#' # A.04       A.04   Roof     Old
#' # A.05       A.05   Roof     New
#' # A.06       A.06 Window     New
#' # A.07       A.07   Wall     Old
#'
#' Value_ParTab_Vector (
#'   demo_partab_Uvalues,
#'   demo_projectdata$Type,
#'   demo_projectdata$Feature,
#' )
#'
#' ## Result:
#' # 1.20 0.20 1.00 1.20 0.15 1.00 1.00
#'
#' @export
Value_ParTab_Vector <-
    function (
        myParTab,
        myCode,
        myDataFieldName,
        myRoundDigits = 3,
        myCodeForNoComponent = "-",
        myValueForNoComponent = 0,
        myErrorValue = -99999
    ) {
        return (
          Replace_NA (
            ifelse (
                myCode == myCodeForNoComponent,
                myValueForNoComponent,
                round (
                    as.numeric (
                        myParTab [
                            cbind (
                                ifelse (myCode %in% rownames (myParTab), myCode, NA),
                                ifelse (myDataFieldName %in% colnames (myParTab), myDataFieldName, NA)
                            )
                        ]
                    ),
                    digits = myRoundDigits
                )
            )
            ,
            myErrorValue
        ))
    }


#. ---------------------------------------------------------------------------------------------



## Parse_StringAsList ()
#' Convert a character string with specific separators to a list
#'
#' Parse_StringAsList evaluates a character string containing specific separators
#' and returns a vector of the character strings betweeen the seperators
#'
#' @param myString the input string
#' @param mySeparator a character used as separator
#' @param myStringToNA a character string that will be converted to NA, except when set to FALSE
#'
#' @return A vector with character strings
#'
#' @examples
#' demostring_1 <- "A,B,_NA_,C"
#' Parse_StringAsList (
#'   myString = demostring_1,
#'   mySeparator = ","
#' )
#' ## Result: "A" "B" NA  "C"
#'
#' demostring_2 <- "A|B|C|D|X|F|G"
#' Parse_StringAsList (
#'   myString     = demostring_2,
#'   mySeparator  = '|',
#'   myStringToNA = "X"
#' )
#' ## Result: "A" "B" "C" "D" NA  "F" "G"
#'
#' @export
Parse_StringAsList <- function (
    myString,
    mySeparator = ",",
    myStringToNA = "_NA_"
    ) {

  # Internal test of function
  #myString <- "A,B,_NA_,C"
  #myString <- "A|B|C|D"
  #myString <- "A|B|C|D|X|F|G"
  #mySeparator <- "|"
  #myStringToNA <- "X"

  myResult <-
    (eval (parse (text = paste0 (
      "c('",
      gsub (pattern = mySeparator,
            replacement = "','",
            x = myString,
            fixed = TRUE), # 2023-07-07: additionally introduced
      "')"
    ))))

  if (myStringToNA != FALSE) {
    myResult [which (myResult == myStringToNA)] <- NA
  }

  return (myResult)

}


## Parse_StringAsCommand ()
#' Execute a character string as command
#'
#' Parse_StringAsCommand excecutes a character string as an R command
#'
#' @param myString the input string
#' @param DF a character used as separator
#'
#' @return A value or vector or an assignment to a variable
#'
#' @examples
#'
#' ## Example 1
#' demostring_1 <- "10 * 12 + 2 * 12"
#' Parse_StringAsCommand (demostring_1)
#' ## Result: 144
#'
#' ## Example 2
#' demo_partab_Uvalues <-
#'   as.data.frame ( rbind (
#'     c ("Roof", 1.2, 0.15),
#'     c ("Wall", 1.0, 0.18),
#'     c ("Window", 2.8, 1.0),
#'     c ("Floor", 0.8, 0.2)
#'   ))
#'
#' colnames (demo_partab_Uvalues) <-
#'   c ("Element", "Old", "New")
#'
#' rownames (demo_partab_Uvalues) <-
#'   demo_partab_Uvalues [ , 1]
#'
#' demo_partab_Uvalues
#' ## View:
#' #        Element Old  New
#' # Roof      Roof 1.2 0.15
#' # Wall      Wall   1 0.18
#' # Window  Window 2.8    1
#' # Floor    Floor 0.8  0.2
#'
#' ## Direct execution:
#' demo_partab_Uvalues ["Wall", "New"]
#' ## View: "0.18"
#'
#' ## First version of function application:
#' demostring_2 <- 'demo_partab_Uvalues ["Wall", "New"]'
#' Parse_StringAsCommand (demostring_2)
#' ## Result:  "0.18"
#'
#' ## Second version of function application
#' ## Useful for parameter tables containing the executable strings (helps keeping the strings short)
#' demostring_3 <- 'DF ["Wall", "New"]'
#' Parse_StringAsCommand (demostring_3, demo_partab_Uvalues)
#' ## Result:  "0.18"
#'
#' @export
Parse_StringAsCommand <- function (
    myString,
    DF = NA
    ) {
  # when applying this on a dataframe, the dataframe must be named "DF" in myString (example: "DF$Var01")
  # Internal test of function
  #Sample <- InputData_Sample
  #myString <- "Sample$Year_State_First <= Sample$Year_Start_CompareCalcMeter_01"

  return (eval (parse (text = myString)))

}




## Parse_StringAsCalculation ()
#' Execute a character string as command
#'
#' Parse_StringAsCalculation excecutes a character string as an R command
#' and returns a number or a vector of numbers
#'
#' @param myString the input string
#' @param DF a character used as separator
#' @param myDecimalPlaces a number indicating the number of decimal places of the result value
#'
#' @return A numerical value or a vector of numerical values
#'
#' @examples
#'
#' ## Example 1
#' demostring_1 <- "10 / 12 + 1 * 13"
#' Parse_StringAsCalculation (
#'   myString = demostring_1,
#'   myDecimalPlaces = 3)
#' ## Result: 13.833
#'
#' ## Example 2
#' demo_partab_Uvalues <-
#'   as.data.frame ( rbind (
#'     c ("Roof",   1.201, 0.157),
#'     c ("Wall",   1.002, 0.182),
#'     c ("Window", 2.887, 1.151),
#'     c ("Floor",  0.799, 0.123)
#'   ))
#'
#' colnames (demo_partab_Uvalues) <-
#'   c ("Element", "Old", "New")
#'
#' rownames (demo_partab_Uvalues) <-
#'   demo_partab_Uvalues [ , 1]
#'
#' demo_partab_Uvalues
#' ## View:
#' # Element   Old   New
#' # Roof      Roof 1.201 0.157
#' # Wall      Wall 1.002 0.182
#' # Window  Window 2.887 1.151
#' # Floor    Floor 0.799 0.123
#'
#' ## Direct execution:
#' demo_partab_Uvalues ["Wall", "New"]
#' ## View: "0.182"
#'
#' ## First version of function application:
#' demostring_2 <- 'demo_partab_Uvalues ["Wall", "New"]'
#' Parse_StringAsCalculation (
#'   myString = demostring_2,
#'   myDecimalPlaces = 2)
#' ## Result:  "0.18"
#'
#' ## Second version of function application
#' ## Useful for parameter tables containing the executable strings (helps keeping the strings short)
#' demostring_3 <- 'DF ["Wall", "New"]'
#' Parse_StringAsCalculation (
#'   myString = demostring_3,
#'   demo_partab_Uvalues)
#' ## Result:  "0.182"
#'
#' @export
Parse_StringAsCalculation <- function (
    myString,
    DF = NA,
    myDecimalPlaces = NA){
  # when applying this on a dataframe, the dataframe must be named "DF" in myString (example: "DF$Var01")
  # Test of function
  #Sample <- InputData_Sample
  #myString <- "Sample$Year_State_First <= Sample$Year_Start_CompareCalcMeter_01"

  myValue <- as.numeric (eval (parse (text = myString)))
  myValue <- ifelse (
    is.na (myDecimalPlaces),
    myValue,
    round (myValue, myDecimalPlaces)
  )
  return (as.numeric (myValue))

}

## Parse_DataFrame_Variable_Index ()
#' Simplify the use of variable names with an index as suffix
#'
#' Parse_DataFrame_Variable_Index is applied to dataframes with column names
#' that have an index as suffix and simplifies extracting parts of it
#' (for example in loops).
#'
#' @param     myDataFrame    a dataframe
#' @param     myVariableName a part of the variable name not including the index
#' @param     myIndex        an integer value or a vector of integer values
#' @param     myDigits       an integer value indicating the number of decimal places of the result
#'
#' @return A numerical value or a vector of numerical values
#'
#' @examples
#'
#'   Parse_DataFrame_Variable_Index(
#'    myDataFrame = clidamonger::data.ta.hd [101:120,],
#'    myVariableName = "M_2021_",
#'    myIndex = 1:12,
#'    myDigits = 1)
#'
#' ## Result:  0.4  3.4   NA  3.5  3.6  3.1   NA   NA   NA   NA -1.8   NA  2.9  3.4  2.6  2.5  4.4   NA   NA   NA
#' #  These are the values of the datasets number 101 to 120
#' #  and the months 1 to 12 of the year 2021 (columns "M_2021_01", "M2021_02", ... "M2021_12")
#'
#' @export
Parse_DataFrame_Variable_Index <- function (
    myDataFrame,
    myVariableName,
    myIndex,
    myDigits = 2
    ) {
  Parse_StringAsCommand (
    paste0 ("DF$",
            myVariableName,
            Format_Integer_LeadingZeros (myIndex, myDigits)),
    myDataFrame
  )
}

## Check_DataFrame_Existing ()
#' Check if a dataframe is existing
#'
#' Check_DataFrame_Existing can be used to check if a dataframe is existing
#' before adding new vectors or assigning values.
#'
#' @param     myDataFrameName   a character string indicating the name of the dataframe
#'
#' @return A boolean value
#'
#' @examples
#'
#' demo_dataframe_1 <- as.data.frame (
#'   x = c (101, 102, 103),
#'   row.names = c("row1", "row2", "row3")
#'   )
#' Check_DataFrame_Existing (
#'   myDataFrameName = "demo_dataframe_1"
#'   )
#' ## Result: TRUE
#'
#' demo_dataframe_1 <- NA
#' Check_DataFrame_Existing (
#'   myDataFrameName = "demo_dataframe_1"
#'   )
#' ## Result: FALSE
#'
#' library(clidamonger)
#'   Check_DataFrame_Existing (
#'    myDataFrameName = "data.ta.hd"
#'    )
#' Result: TRUE
#'
#' #' detach("package:clidamonger", unload = TRUE)
#'   Check_DataFrame_Existing (
#'    myDataFrameName = "data.ta.hd"
#'    )
#' ## Result: FALSE
#' @export
Check_DataFrame_Existing <- function (
    myDataFrameName
    ) {
  return (exists (myDataFrameName) &&
            is.data.frame (get(myDataFrameName)))
}
