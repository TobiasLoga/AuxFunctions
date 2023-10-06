# AuxFunctions

### Auxiliary functions with focus on emulating Excel functions

Most of the functions were created when the algorithms of the workbook "EnergyProfile.xlsm"
were parsed into an R script in the framework of the MOBASY project. 
The idea is to emulate the structure of the Excel function arguments in order to simplify parsing.
More information: https://www.iwu.de/forschung/energie/mobasy/ 


The package consists of the following functions (details in the respective help texts)

    Check_DataFrame_Existing ()
    Format_Integer_LeadingZeros ()
    Format_Numeric_Percentage ()
    grapes-xl_JoinStrings-grapes ()
    Parse_DataFrame_Variable_Index ()
    Parse_StringAsCalculation ()
    Parse_StringAsCommand ()
    Parse_StringAsList ()
    Reformat_InputData_Boolean ()
    Replace_NA ()
    Replace_NULL ()
    String_ParTab ()
    TimeStampForDataset ()
    TimeStampForFileName ()
    Value_ParTab ()
    Value_ParTab_Vector ()
    xl_AND ()
    xl_AVERAGE ()
    xl_CONCATENATE ()
    xl_DATE ()
    xl_EOMONTH ()
    xl_FIND ()
    xl_LEFT ()
    xl_MID ()
    xl_NOT ()
    xl_OR ()
    xl_RIGHT ()
    xl_SUMPRODUCT ()
    xl_TEXT ()


---

### Usage

```r
library (AuxFunctions)

```
---

### License

<a rel="license" href="https://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

---


