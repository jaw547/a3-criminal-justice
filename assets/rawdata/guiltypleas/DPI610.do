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

// renaming collapsed states & dropping territories

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

// 1999 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY1999_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY1999_OUTCOMEQ_DISTRCTQ") 

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

gen year = 1999

drop guiltyplea total statenum

save 1999guiltyplea, replace

// 2000 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2000_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2000_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2000

drop guiltyplea total statenum

save 2000guiltyplea, replace


// 2001 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2001_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2001_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2001

drop guiltyplea total statenum

save 2001guiltyplea, replace

// 2002 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2002_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2002_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2002

drop guiltyplea total statenum

save 2002guiltyplea, replace



// 2003 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2003_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2003_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2003

drop guiltyplea total statenum

save 2003guiltyplea, replace



// 2004 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2004_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2004_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2004

drop guiltyplea total statenum

save 2004guiltyplea, replace


// 2005 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2005_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2005_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2005

drop guiltyplea total statenum

save 2005guiltyplea, replace


// 2006 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2006_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2006_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2006

drop guiltyplea total statenum

save 2006guiltyplea, replace


// 2007 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2007_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2007_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2007

drop guiltyplea total statenum

save 2007guiltyplea, replace


// 2008 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2008_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2008_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2008

drop guiltyplea total statenum

save 2008guiltyplea, replace


// 2009 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2009_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2009_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2009

drop guiltyplea total statenum

save 2009guiltyplea, replace


// 2010 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2010_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2010_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2010

drop guiltyplea total statenum

save 2010guiltyplea, replace


// 2011 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2011_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2011_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2011

drop guiltyplea total statenum

save 2011guiltyplea, replace

// 2012 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2012_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2012_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2012

drop guiltyplea total statenum

save 2012guiltyplea, replace


// 2013 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2013_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2013_OUTCOMEQ_DISTRCTQ.txt") 

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

gen year = 2013

drop guiltyplea total statenum

save 2013guiltyplea, replace


// 2014 Database
 
clear

import excel "/Users/martagarnelocaamano/Documents/HKS/Semester 2/Data and programming/Criminal justice data visualization/Trials databases/FY2014_OUTCOMEQ_DISTRCTQ.xlsx", sheet("FY2014_OUTCOMEQ_DISTRCTQ") 

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

gen year = 2014

drop guiltyplea total statenum

save 2014guiltyplea, replace

// appending all databases!

clear 

use 1998guiltyplea

append using 1999guiltyplea

append using 2000guiltyplea

append using 2001guiltyplea

append using 2002guiltyplea

append using 2003guiltyplea

append using 2004guiltyplea

append using 2005guiltyplea

append using 2006guiltyplea

append using 2007guiltyplea

append using 2008guiltyplea

append using 2009guiltyplea

append using 2010guiltyplea

append using 2011guiltyplea

append using 2012guiltyplea

append using 2013guiltyplea

append using 2014guiltyplea

drop if state=="Puerto Rico" | state=="Guam" | state=="Northern Mariana Islands" | state=="Virgin Islands"

rename state x

rename year y

rename pcplea value

export delimited guiltyplea.csv, replace

