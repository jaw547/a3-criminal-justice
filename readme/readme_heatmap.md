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

The data guiltypleas.csv was obtained from the website of the Federal Justice Statistics Resource Center (FJSRC), Bureau of Justice Statistics (https://www.bjs.gov/fjsrc/) and transformed in Excel and Stata.

The code for the D3 heatmap was obtained from the following website: https://bl.ocks.org/Bl3f/cdb5ad854b376765fa99 

* Code for labels: 

The code for the D3 legend was obtained from the following website: https://www.visualcinnamon.com/2016/05/smooth-color-legend-d3-svg-gradient.html [Rectangle with colour gradient]

* Code for axis: http://bl.ocks.org/nbremer/5cd07f2cb4ad202a9facfbd5d2bc842e 

* Code for tooltip: https://codepen.io/aleave/pen/zZXJzM

* Code for labels: http://jsfiddle.net/teddyrised/jLxbawhz/2/

# Software and languages used

Sublime text 
Javascript
Html 
CSS

# Trasformation steps

## Heatmap

1. Changed width and height of svg to fit larger chart [lines 7-8].
2. Changed dimensions of the cells to make them not a square but a rectangle. Changed dimensions of the "fill" of the cells to  preserve a blank space between cells [lines 1-5].
3. Changed data inputed [line 12]
4. Changed axis scales to fit the new cell size [lines 28 and 39]
5. Changed color gradient [lines 49-50]
* Increased the number of points where the color would change/increased the number of colours (.domain)
* Changed color palette (.range)
6. Changed the attributes of the cells, so that they reflect the new variables representing height and width of the filled area [lines 67-68]
7. Added axis labels [lines 103-120]
8. Added footnotes with hyperlinks [lines 174-203]
9. Added tooltip and failed to fully replicate it, as it is still in the wrong position [lines 52-54 and 73-83].

## Legend

1. Changed the width and height of the legend [lines 131-132]
2. Changed the position of the legend [lines 133-136]
3. Added legend label [lines 146-154] 
4. Added legend axis [lines 156-171]
* Changed the axis length to fit the legend width (.range) [line 158]
* Changed the range of points that would be represented in the axis through ticks (.domain) [line 159]
* Changed the number of ticks [line 164]
* Changed the position of the axis [line 170]
