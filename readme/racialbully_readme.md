# Content

* Project 
* Data and code source
* Software used
* Trasformation steps

# Project

The D3.js visualization "heatmap.js" was transformed as a part of the final project of the course DPI-691M Data and Programming for Policymakers, led by Professor Dhrumil Mehta.

Team members include: Michael Ho, Marta Garnelo, Daniela Philipson and Jackson Wright. Marta Garnelo modified the source visualization as described in this document.

## Aim
Transform a D3.js heatmap script so that it can properly visualize data on the proportion of people who are convicted through guilty pleas in each U.S. State and territory. 


# Data and code source
Original source data located - 

# Software and languages used

Sublime text 
Excel
Stata
Javascript
HTML
Python 

# Trasformation steps

## CRDC 2013-14 Data Transformation Process - Including Python API Program
Start with 2013-14 CRDC raw data file, 96,000 schools with latitudes and longitudes (represents all public schools in America).  Need to convert to average racial bullying % per FIPS county code.
Stata create variables
Stata drop bad data
Stata remove a billion unnecessary columns
Excel convert to percentages
Excel convert to TSV
Python script to convert lat long to FIPS from FCC census
Excel remove Lat and Long columns
Excel remove any negative values that snuck in
Excel pivot table, FIPS and average values for average per county
Save as TSV
Final = two columns, FIPS and value


## State Choropleth D3 Manipulation (Graph 1)
Change legend to position = relative

## County Choropleth D3 Manipulation(Graph 2)
Change scale of data from 1 to 10% to X
Change color range from scaleBlues to ScaleX


## Homepage/Bootstrap Formatting Notes
Use bootstrap templates to create nav bar with links for all pages
Use bootstrap template to create formatted index with thumbnails for pictures