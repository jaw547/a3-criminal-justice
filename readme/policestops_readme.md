# Police stops data

For the visualization on police stops regarding Marijuana violations in Colorado,
I used data from the Stanford Open Policing Project (https://stacks.stanford.edu/file/druid:py883nd2578/CO-clean.csv.gz). 

## Objective
Answer the questions: Did the police continue stopping people regarding marijuana violations in Colorado during the period 
before legalization and after referendum? If so, who did they stop? The main aim of this study is to explore whether police stops operate under racial biases during a period during which there are no incentives to prosecute marijuana violations. As such, we believe the 
time frame between referendum and legalization serve as a propitious natural experiment to observe trends of this sort. 

# To clean the data, I followed the next steps:

## CSV
* I downloaded the data into a CVS format.

## STATA
* Imported the data into STATA and transformed into a DTA file. This was due to Excel and R 
not having the capacity to download and view the total number of observations which exceed one million. 
* Using STATA, I filtered the number of observations by selecting only those police stops that were
related to marijuana violations using the violation_raw variable which categorized them as "Other".
* I then created a new date variable that kept month and year only. I did this by separating month, year, 
and day into different variables and concatenating month and year.
* I collapsed the number of observations using the month - year variable by race and gender. The end result
were 7 columns that indicate the total number of male, female, black, asian, hispanic, and white 
detainees by month and year in Colorado.

## Excel
* Exported data to new CSV file and opened it in excel. 
* Consequently, I regrouped the data into three columns as to make it compatible with the 
D3 visualization I selecte. These variables are key, value, and date; and they indicated identity attribute 
(white, male, female, black, asian, or hispanic), number of police stops, and month - year.
* Using the Java Script file I altered date variable specifications to make it compatible with the js date formats.

# Appendix - Stata code 

```
 *******************************************************************
* File-Name:      C0_marijuana.do       	                       *
* Date:           12jan 2018                                      *
* Author:         Daniela Philipson                               *
* Purpose:        Basicos de STATA                                *
* Input File:     Varios                                          *
* Output Files:   none                                            *
* Data Output:    none                                            *
* Previous file:  none                                            *
* Status:         in use                                          *
* Machine:        Mac_DPG                                         *
*******************************************************************

gl policestops "/Users/danielaphilipson/Documents/HKS2017/DPI691M/" 

import delimited "$policestops/CO_marijuana1.csv", rowfirst

***/Split date into month and year, rename date variables and concat into month-year id/

split stop_date, p("/")

rename stop_date1 year

rename stop_date2 month

rename stop_date3 

gen slash = "/"

egen my = concat(month slash year)

gen n = 1 

save "$policestops/CO_marijuana.dta", replace

*** /Collapse race sum by month-year/

collapse (sum) n if driver_race == "White", by(my)

rename n white

save "$policestops/CO_marijuana_race1.dta", replace

clear

use "$policestops/CO_marijuana.dta"

collapse (sum) n if driver_race == "Hispanic", by(my)

rename n hispanic

save "$policestops/CO_marijuana_race2.dta", replace

clear

use "$policestops/CO_marijuana.dta"

collapse (sum) n if driver_race == "Asian", by(my)

rename n asian

save "$policestops/CO_marijuana_race3.dta", replace

clear

use "$policestops/CO_marijuana.dta"

collapse (sum) n if driver_race == "Black", by(my)

rename n black

save "$policestops/CO_marijuana_race4.dta", replace

clear


*** /Collapse gender sum by month-year/
use "$policestops/CO_marijuana.dta"

collapse (sum) n if driver_gender == "F", by(my)

rename n female

save "$policestops/CO_marijuana_gender1.dta", replace

clear

use "$policestops/CO_marijuana.dta"

collapse (sum) n if driver_gender == "M", by(my)

rename n male

save "$policestops/CO_marijuana_gender2.dta", replace

clear

*** /Loop merge files/

forvalue x = 1/4 {
	use $policestops/CO_marijuana_race`x'.dta
	merge 1:m my using "$policestops/CO_marijuana.dta"
	drop _merge
	save "$policestops/CO_marijuana.dta", replace
	clear
	}
	
forvalue x = 1/2 {
	use $policestops/CO_marijuana_gender`x'.dta
	merge 1:m my using "$policestops/CO_marijuana.dta"
	drop _merge
	save "$policestops/CO_marijuana.dta", replace
	}

foreach x in white black hispanic asian female male {
  replace `x' = 0 if missing(`x') 
}	

***/ Add last details, delete duplicates and sort month and year/

keep year month white black hispanic asian female male my 

duplicates drop

gen total = female + male

egen myy = concat(month year)

gen countvar = length(myy)

gen z = "0"

egen mmyy = concat(z myy) if countvar ==3  

replace mmyy = myy if countvar == 4

destring month, gen(m)

destring year, gen(y)

sort y m 

br

save "$policestops/CO_marijuana.dta", replace

export delimited using "/Users/danielaphilipson/Documents/HKS2017/DPI691M/CO_marijuana_clean.csv", replace

