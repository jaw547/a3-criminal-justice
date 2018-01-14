# a3-criminal-justice

For the visualization on police stops regarding Marijuana violations in Colorado, ///
I used data from the Stanford Open Policing Project (https://openpolicing.stanford.edu/data/). 

To clean the data, I followed the next steps:

1. I downloaded the data into a CVS format.
2. Imported the data into STATA and transformed into a DTA file. This was due to Excel and R ///
not having the capacity to download and view the total number of observations which exceed one million. 
3. Using STATA, I filtered the number of observations by selecting only those police stops that were ///
related to marijuana violations using the "keep if" command. 
4. I then created a new date variable that kept month and year only.
5. I collapsed the number of observations using the new date variable by race and gender. 
6. Exported data to new CSV file and regrouped it into three variables as to make it compatible with ///
D3 visualizations. These variables are key, value, and date. 
7. Using the Java Script file I formatted date variable as to record it by month - year.
