# Content

* Project
* Data and code source
* Software used
* Transformation steps

# Racial Bullying Mapping Project

The 2013-14 CRDC data set was transformed to match two different D3 United States Chorpleth visualizations, "mapscript.js" and "statemapscript.js," as a part of the final project of the course DPI-691M Data and Programming for Policymakers, led by Professor Dhrumil Mehta.

Team members include: Michael Ho, Marta Garnelo, Daniela Philipson and Jackson Wright. Michael Ho modified the source visualization as described in this document, and seen here:  https://jaw547.github.io/a3-criminal-justice/crdc.html

## Aim

Transform two D3.js choropleth scripts so that they can properly visualize data on the states and counties reporting the highest levels of student bullying by race in the United States.


# Data sources
Original source data located here - from Data.Gov
https://inventory.data.gov/dataset/2acc601e-9806-4dff-b144-f8a5e7c095b8/resource/3dc84a95-526a-4b90-aacd-72f60d4fecbc/download/crdc201314csv.zip

D3 Choropleth Sources (also located in the button on my website)
* State Choropleth - https://bl.ocks.org/wboykinm/dbbe50d1023f90d4e241712395c27fb3

* County Choropleth - https://bl.ocks.org/mbostock/4060606

# Software and languages used

* Sublime text 
* Excel
* Stata
* Javascript
* HTML
* Python 

# File Map
1. Visualization.do - https://github.com/jaw547/a3-criminal-justice/blob/master/assets/Visualization.do
	*  Stata do used to do quick cleaning of the 2013-14  CRDC

2. RaceBullyState.csv - https://github.com/jaw547/a3-criminal-justice/blob/master/assets/RaceBullyState.csv
	*  Two columned CSV with state names and their average racial bullying percentage, created through quick analysis of the Stata cleaned CRDC file.  First D3, the state visualization, reads this file.

3. CRDCSimple.tsv - https://github.com/jaw547/a3-criminal-justice/blob/master/assets/CRDC1314Simple.tsv
	*  Cleaned CRDC file with just latitudes, longitudes, and race bully percent for all schools.  Used in the block python conversion.

4. blockconversion.py - https://github.com/jaw547/a3-criminal-justice/blob/master/assets/blockconversion.py
	*  Python program which reads CRDCSimple.tsv, outputs the Latitude and Longitude of each row to the FCC API FIPS converter, and writes the output into the countybully.tsv file.

5. countybully.tsv - https://github.com/jaw547/a3-criminal-justice/blob/master/assets/countybully.tsv
	*  Two columned tsv file with FIPS county codes, created through analysis of the Stata cleaned CRDC file and the blockconversion.py program.  The second D3, the county visualization, reads this file.

6. statemapscript.js - https://github.com/jaw547/a3-criminal-justice/blob/master/scripts/statemapscript.js
	*  Script that creates and appends the first D3 to crdc.html.  Reads the RaceBullyState csv. 

7. mapscript.js - https://github.com/jaw547/a3-criminal-justice/blob/master/scripts/mapscript.js
	*  Script that creates and appends the second D3 to crdc.html.  Reads the countybully tsv.

8. statemapstyles.css - https://github.com/jaw547/a3-criminal-justice/blob/master/styles/statemapstyle.css
	*  Stylesheet for state map D3.

9. crdcstyles.css - https://github.com/jaw547/a3-criminal-justice/blob/master/styles/crdcstyles.css
	*  Stylesheet for crdc.html overall

# Transformation steps

## CRDC 2013-14 Data Transformation Process to countybully.tsv.

I started with the 2013-14 CRDC raw data file, containing 96,000 schools (rows) and over 1500 data points (columns) including latitudes and longitudes.  The end result is a two columned TSV file with FIPS county codes and racial bully percentages. 

1. Used STATA to manipulate and clean data.  See Visualization.do for details

	* Note I created RaceBullyState.csv here using a pivot table in excel, the state name column, and the race_bully_percent variable.

2. After running do file, I used "edit" to remove all columns (1500+) except the race_bully_percent and the latitude and longitude columns.

	* Note: I only analyzed location and total % of students experiencing racial bullying.  In the Stata data preparation, I created many other variables which I would theoretically like to chart out in future sprints, including breakdowns by school type, ethnicity, gender, LEP, and SPED status.

3. I opened the data in excel and converted the race_bully_percent into an actual percentage (multiply by 100)

4. Changed the file to .tsv in Linux with a simple rename

5. Wrote and executed a Python script (with the help of Ihsaan) to convert my lat and long columns into a FIPS county code for each school.  See blockconversions.py for details

6. I used Excel to remove the latitude and longitude columns, as well as zeroing out any negative values that snuck in.

7. I used an Excel pivot table to find the average racial_bully_percent by FIPS code and saved as TSV, changed extension to TSV in Linux.

8. After these steps, I was left with a two columned tsv with FIPS ids and average Racial Bullying Rates.

## State Choropleth D3 Manipulation (Graph 1)

* Added a "1" to any variable names that matched Graph 2, such as "svg."

* Changed lowColor from white (f9f9f9) to grayish (f4f4f4)

* Added a div tag to the html, map, and appended this svg to #map instead of to the body

* Changed legend to position = relative, tinkered around with the position.  For next sprint I would like this to be more adaptive to the size of the window, so it always appears next to the svg and never below it.

* I attempted to add in a tooltip to this graph to no avail, only able to get a highlight on mouse hover working but no information to pair with it.  For the next sprint I would like to get this up and running so users can hover over a state and see the % of racial bulllying.

## County Choropleth D3 Manipulation(Graph 2)

*  Changed name of var unemployment to var bully for clarity 

* Changed the scale of the data from 2% to 10% to [0, 0.1, 0.3, 0.5, 1, 2, 3, 5, 10]%

* Changed color range from schemeBlues to schemeBuPu, the two colors makes it obvious when counties are reporting above 1% racial bullying, wheras a one color scheme would not be discernable.

* Changed the legend to read "Racial Bullying %" and changed the tick marks.  For the next sprint, I would like to update it so there are no tick marks/labels below 1%.

## Other Stuff We're Proud Of - Homepage, Bootstrap, and Formatting Notes

* We first found and utilized the basic bootstrap navigation template to create the bare bones format for our pages.  Then, through exploring its functionality we decided on the "Jumbotron" setting for our Hed container, and the "col-sm-10 col-sm-offset-1" div class for our body.  We also used "blockquote" to some degree, as well as p class = "lead" to create a unified look.

* We used another bootstrap template for the homepage, changing around the "About Us" section to a container near the footer instead of in the box where it now says "Contact your congressman."  This home page provides coherence for our four data visualizations as related to criminal justice.

* Finally, not a bootstrap specific feature, but we added in a statue of liberty favicon to our head.