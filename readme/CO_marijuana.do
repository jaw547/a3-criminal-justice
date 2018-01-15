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

