# Content

* Project 
* Data source
* Software used
* Trasformation steps
* Appendix - Stata code (sample for one year)

# Project

The dataset "guiltyplea.csv" was transformed as a part of the final project of the course DPI-691M Data and Programming for Policymakers, led by Professor Dhrumil Mehta.

Team members include: Michael Ho, Marta Garnelo, Daniela Philipson and Jackson Wright. Marta Garnelo conducted the data transformation described in this document.

## Aim
Transform the dataset to a format in which it can be inputed into a D3.js heatmap. The code for the D3 visualization chosen was obtained from the following website: https://bl.ocks.org/Bl3f/cdb5ad854b376765fa99 

# Data source

The data was obtained from the website of the Federal Justice Statistics Resource Center (FJSRC), Bureau of Justice Statistics (https://www.bjs.gov/fjsrc/). I selected the year (1998-2014), the variable "Outcome for a defendant in a case", added the column "U.S. Federal Judicial District" and downloaded the file. 

# Trasformation steps

The data was originally in a table in .xlsx format. 

The judicial districts were the table's columns and the different categories for the variable "outcome for a defendant in a case" were the table's rows. 

## In Excel

0. Erased the information different from the table (title and footnotes).

## In STATA (version 15.0)

1. Installed package sxpose and set working directory.

2. Imported the database for the year 1998 in .xlsx.

3. Prepared the dataset to be transposed.

* Changed the name of the first observation of the first column to "state", so that it could be an appropiate variable name for the variable capturing the name of the judicial district.
* Changed the name of the variables identifying cases where the defendant was convicted to variable names valid in Stata ('guiltyplea', 'nolo_contendere', 'jurytial' and 'benchtrial').
* Dropped unnecesary variables (N, Missing/Unknown, Total).
* Replaced missing values "*" with "5". The original files said that when the number of cases under a particular category was less than 10, the number was not displayed to avoid disclosing confidential information. 

4. Transposed the database - this resulted in a dataset where the columns were the variables identifying court outcomes and the name of the federal judicial distric figured in the first column, under the variable "state". 

5. Generated "total" variable which added the variables 'guiltyplea', 'nolo_contendere', 'jurytial' and 'benchtrial' - all identifying cases where the defendants were convicted. 

6. Turned the "state" variable"(originally a string) into a numeric variable, which assigned consecutive numbers to each judicial district

7. Assigned the same numerical value within the variable "state" to all judicial districts part of the same State.

8. Collapsed the database, so that there was one observation per State and the number of cases under different outcome categories reflected the sum of all cases in the State (sum of all cases accross judicial districts in the same State). 

9. Turned the "state" variable back into a string and changed some of the observations' values so that it represented State names and not judicial districts (i.e. Alabama, instead of Alabama Middle).

10. Generated a variable that captures the percentage of defendants convicted as a result of guilty pleas, dividing the number of defendants convicted through guilty pleas over the total number of defendants convicted. 

11. Generated the year variable, which assigned the same value to all observations.

12. Dropped all variables except from "state", "year", "pc". 

13. Saved database in .dta format.

14. Repeated the process for the remaining datasets corresponding to years 1999 - 2014.

15. Appended databases.

16. Dropped U.S. territories.

17. Changed variable names to fit those of the D3.js script.

18. Saved in .csv format. 

# Appendix - Stata code (sample for one year)

```
/***********************

DPI-610
Final Project
Marta Garnelo Caamano
1/11/2018 

************************/

cap ssc inst sxpose

clear 

cd "~/Google Drive/HKS/DPI610"

//log using dpi610_log.txt, text replace

// 1998 Database

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY1998_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY1998_OUTCOMEQ_DISTRCTQ") 

replace A="state" if A=="Outcome for a defendant in a case"

replace A="guiltyplea" if A=="Convicted - plea guilty"

replace A="nolo_contendere" if A=="Convicted - plea is nolo"

replace A="jurytrial" if A=="Convicted by jury or guilty but insane"

replace A="benchtrial" if A=="Convicted by court or guilty but insane"

drop B 
drop CT
drop CS

foreach var of varlist _all {
	replace `var' = "5" if `var' == "*"
}

// transposing 

sxpose, clear force firstnames destring

drop _var2 _var3 _var5 Mistrial _var6 Other _var12 Total

generate total = guiltyplea + nolo_contendere + jurytrial + benchtrial

// grouping observations by state, assigning same enconde number, then collapsing 

encode state, gen(statenum)

replace statenum=1 if statenum==2 | statenum==3

replace statenum=6 if statenum==7 

replace statenum=8 if statenum==9 | statenum==10 | statenum==11

replace statenum=16 if statenum==17 | statenum==18

replace statenum=19 if statenum==20 | statenum==21

replace statenum=25 if statenum==26 | statenum==27

replace statenum=28 if statenum==29 

replace statenum=30 if statenum==31 

replace statenum=33 if statenum==34 

replace statenum=35 if statenum==36 | statenum==37

replace statenum=41 if statenum==42

replace statenum=44 if statenum==45

replace statenum=46 if statenum==47

replace statenum=54 if statenum==55 | statenum==56 | statenum==57

replace statenum=58 if statenum==59 | statenum==60 

replace statenum=63 if statenum==64

replace statenum=65 if statenum==66 | statenum==67 

replace statenum=69 if statenum==70 | statenum==71 

replace statenum=76 if statenum==77 | statenum==78 

replace statenum=79 if statenum==80 | statenum==81 | statenum==82 

replace statenum=86 if statenum==87 

replace statenum=88 if statenum==89

replace statenum=90 if statenum==91

replace statenum=92 if statenum==93

// collapsing to keep 1 obvs per state

collapse (sum) total (sum) guiltyplea, by(statenum)

// renaming collapsed states

decode statenum, gen(state)

replace state="Alabama" if state=="Alabama Middle"
replace state="Arkansas" if state=="Arkansas Eastern"
replace state="California" if state=="California Central"
replace state="Florida" if state=="Florida Middle"
replace state="Georgia" if state=="Georgia Middle"
replace state="Illinois" if state=="Illinois Central"
replace state="Indiana" if state=="Indiana Northern"
replace state="Iowa" if state=="Iowa Northern"
replace state="Kentucky" if state=="Kentucky Eastern"
replace state="Louisiana" if state=="Louisiana Eastern"
replace state="Michigan" if state=="Michigan Eastern"
replace state="Mississippi" if state=="Mississippi Northern"
replace state="Missouri" if state=="Missouri Eastern"
replace state="New York" if state=="New York Eastern"
replace state="North Carolina" if state=="North Carolina Eastern"
replace state="Oklahoma" if state=="Oklahoma Eastern"
replace state="Pennsylvania" if state=="Pennsylvania Eastern"
replace state="Tennessee" if state=="Tennessee Eastern"
replace state="Texas" if state=="Texas Eastern"
replace state="Virginia" if state=="Virginia Eastern"
replace state="Washington" if state=="Washington Eastern"
replace state="West Virginia" if state=="West Virginia Northern"
replace state="Wisconsin" if state=="Wisconsin Eastern"

// generating pc of convicted by guilty plea

gen pcplea = guiltyplea/total

// gen year variable

gen year = 1998

drop guiltyplea total statenum

save 1998guiltyplea, replace

```
