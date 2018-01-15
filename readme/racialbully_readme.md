# Content

* Project 
* Data and code source
* Software used
* Trasformation steps

# Project

The 2013-14 CRDC data set was transformed to match two different D3 United States Chorpleth visualizations, "mapscript.js" and "statemapscript.js," as a part of the final project of the course DPI-691M Data and Programming for Policymakers, led by Professor Dhrumil Mehta.

Team members include: Michael Ho, Marta Garnelo, Daniela Philipson and Jackson Wright. Michael Ho modified the source visualization as described in this document.

## Aim
Transform two D3.js choropleth scripts so that they can properly visualize data on the states and counties reporting the highest levels of student bullying by race in the United States.


# Data and code source
Original source data located - from Data.Gov
https://inventory.data.gov/dataset/2acc601e-9806-4dff-b144-f8a5e7c095b8/resource/3dc84a95-526a-4b90-aacd-72f60d4fecbc/download/crdc201314csv.zip

# Software and languages used

* Sublime text 
* Excel
* Sata
* Javascript
* HTML
* Python 

# Trasformation steps

## CRDC 2013-14 Data Transformation Process - Including Python API Program
1. Start with 2013-14 CRDC raw data file, 96,000 schools with latitudes and longitudes (represents all public schools in America).  Need to convert to average racial bullying % per FIPS county code.
2. Stata create variables
3. Stata drop bad data
4. Stata remove a billion unnecessary columns
5. Excel convert to percentages
6. Excel convert to TSV
7. Python script to convert lat long to FIPS from FCC census
8. Excel remove Lat and Long columns
9. Excel remove any negative values that snuck in
10. Excel pivot table, FIPS and average values for average per county
11. Save as TSV
12. Final = two columns, FIPS and value


## State Choropleth D3 Manipulation (Graph 1)
* Added a "1" to any variable names that matched Graph 2, such as "svg."

* Changed lowColor from white (f9f9f9) to grayish (f4f4f4)

* Added a div tag to the html, map, and appended this svg to #map instead of to the body

* Change legend to position = relative, tinkered around with the position.  For next sprint I would like this to be more adaptive to the size of the window, so it always appears next to the svg and never below it.

* I attempted to add in a tooltip to this graph to no avail.  For the next sprint I would like to get this up and running so users can hover over a state and see the % of racial bulllying.

## County Choropleth D3 Manipulation(Graph 2)
* Changed name of var unemployment to var bully for clarity 
* Changed the scale of the data from 2% to 10% to [0, 0.1, 0.3, 0.5, 1, 2, 3, 5, 10]%
* Changed color range from schemeBlues to schemeBuPu, the two colors makes it obvious when counties are reporting above 1% racial bullying, wheras a one color scheme would not be discernable.
* Changed the legend to read "Racial Bullying %" and changed the tick marks.  For the next sprint, I would like to update it so there are no tick marks/labels below 1%.


## Other Stuff We're Proud Of - Homepage, Bootstrap, and Formatting Notes
* We first found and utilized the basic bootstrap navigation template to create the bare bones format for our pages.  Then, through exploring its functionality we decided on the "Jumbotron" setting for our Hed container, and the "col-sm-10 col-sm-offset-1" div class for our body.  We also used "blockquote" to some degree, as well as p class = "lead" to create a unified look.

* We used another bootstrap template for the homepage, changing around the "About Us" section to a container near the footer instead of in the box where it now says "Contact your congressman."  This home page provides coherence for our four data visualizations as related to criminal justice.

* Finally, not a bootstrap specific feature but we added in a statue of liberty favicon to our head.