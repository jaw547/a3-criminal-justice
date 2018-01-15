#Crime & Learning
* Project Overview
* Data Source
* Data Transformation in Tableau
* Visualization Customization

##Project Overview

I used the 2016 National Crime Victimization Survey Person Record-Type File (linked below). The research question I hoped to answer was: Is there a link between being a victim of crime and performance in school? Given the nature of the data, the question became more broad. Is there a link between being a victim of crime and difficulty learning?

##Data Source
I downloaded the raw NCVS dataset file (DS3: Person Record-Type File) as a TSV. [The data and additional information about the NCVS data can be found here.](http://www.icpsr.umich.edu/icpsrweb/NACJD/studies/36828)

##Data Transformation in Tableau
The data transformation occurred almost entirely in Tableau. I have documented the steps below, and was unable to replicate the steps in Python/Pandas despite my best efforts.

1. Identify and alias relevant variables in dataset
	- Sex - V3017
	- Race - V3023A
	- NumCrimeIncidents - V3081
	- LearningDifficulty? - V3_V4526H5
	- ForcedSex? - V3046

2. Create calculated fields
	- CrimeReported?
		- 	CASE [NumCrimeIncidents]
			WHEN 0 THEN "N"
			ELSE "Y"
			END

	- White?
		-	CASE [Race]
			WHEN 1 THEN "White"
			ELSE "Not White"
			END

3. Filter data by variables for each visualization.
	- Overall Viz by Gender
		- LearningDifficulty?
			- Yes, No (1,2)
		- Sex
			- Male,Female (1,2)


	- Forced Sex Viz by Gender
		- Learning Difficulty 1,2
		- Sex 1,2
		- ForcedSex?
			- Yes, No (1,2)

4. Create stacked bar chart
	- Y-axis --> % of Total count of LearningDifficulty? (i.e. within a column)
	- X-axis --> Gender | Yes No Crime or Forced Sex
	- Colors --> LearningDifficulty? Y/N

##Visualization Customization
I adapted my visualization from this [Stacked bar chart Block by Michael Stanaland.](http://bl.ocks.org/mstanaland/6100713)

I changed the data source by manually entering percentages from the Tableau stacked bar chart. The data for each chart are below:

- Chart 1 - Any Crime by Gender
	- [
  { "sex": "Male-No", "No Learning Difficulty": "95.91", "Learning Difficulty": "4.09"},
  { "sex": "Male-Yes", "No Learning Difficulty": "91.61", "Learning Difficulty": "8.39"},
  { "sex": "Female-No", "No Learning Difficulty": "95.74", "Learning Difficulty": "4.26"},
  { "sex": "Female-Yes", "No Learning Difficulty": "90.81", "Learning Difficulty": "9.19"},
]
- Chart 2 - Forced Sexual Contact by Gender
	- [
  { "sex": "Male-No", "No Learning Difficulty": "95.74", "Learning Difficulty": "4.26"},
  { "sex": "Male-Yes", "No Learning Difficulty": "70", "Learning Difficulty": "30"},
  { "sex": "Female-No", "No Learning Difficulty": "95.53", "Learning Difficulty": "4.47"},
  { "sex": "Female-Yes", "No Learning Difficulty": "88.89", "Learning Difficulty": "11.11"},
]

I made the following additional changes to the visualizations.

* Changed colors to match site theme
* Added "%" to y-axis
* Updated legend to take two arguments instead of four.
* Reversed order of bars to put learning difficulty on bottom.
* Adjusted width and height