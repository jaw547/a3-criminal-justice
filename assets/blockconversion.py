# I want to read my tsv file, take all of the latitudes in the latitude column and put it into 
# the FCC API latitude, same with longitude, and for each result get the FIPS code, and append that FIPS code
# to a new tsv doc.  There will be many of the same county. I will then average each county FIP.

# Read TSV/CSV file
import csv
import requests
import json

with open('assets/CRDC1314Simple.tsv') as f:
    reader = csv.DictReader(f, delimiter='\t')
    rows = list(reader)

# loop through data for each row, call census API with latitude and longitude variables
final_data = []
for i, locations in enumerate(rows):

	latitude = locations['ccd_latcod']
	longitude = locations['ccd_loncod']

#Call API	
	url = "http://data.fcc.gov/api/block/find?format=json&latitude="+latitude+"&longitude="+longitude+"&showall=[true]"
	try:
		response = requests.get(url)
		data= json.loads(response.text)

	# For each JSON created, get the County:{FIPS} dataset
		locations["FIPS"] = data["County"]["FIPS"]
		final_data.append(locations)

		print("Pulling record " + str(i) + "...")
	except:
		print("Something went wrong for record " + str(i))
		with open("errors.csv", "a") as f:
			writer = csv.writer(f)
			writer.writerow(["Something went wrong for record " + str(i)])

# Write new TSV file with appended FIPS county code
with open('CRDCBully.tsv', 'w') as f:
    writer = csv.writer(f)
    writer.writerow(["latitude", "longitude", "FIPS","Race_Bully_Percent"])
    for counties in final_data:
    	writer.writerow([counties["ccd_latcod"],counties["ccd_loncod"],counties["FIPS"], counties["race_bully_percent"]])
    	