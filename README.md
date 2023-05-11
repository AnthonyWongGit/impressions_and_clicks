# impressions_and_clicks

To run the script, type the following into the command line:

python3 src/impression_click.py data/impression_data.csv data/click_data.csv

This will output the average time and distance between all impressions and their corresponding click (if applicable)

The script uses pandas, h3, sys, and time modules to complete the calculations. These were used for the following purposes:
    * pandas - reads the csv as a dataframe and performs inner on the impression dataframe against the click dataframe
    * h3 - calculates distances given latitude and longitude values
    * sys - allows flexibility for naming the csv files
    * time - calculates the time taken to run the script

The csv files are first read using the pandas read csv, and stores them as a dataframe. An inner join is performed to match against impressions which have a corresponding click. This will discard rows with no match.

For each row in the newly merged dataframe, the time difference is calculated by subtracting the click timestamp against the impression timestamp, and then adding it to a time list. The distance is also calculated using the h3 module, by taking the latitude/longitude values of the impression and click, taking the distance, and then finally adding it to a distance list.

The results are printed by taking the average value of the lists, and formatting it into the correct unit of measurement.

# engagement

Created an SQL file which creates the necessary tables to store the data from the CSV files

Created another SQL file to run queries and return the data required

No additional packages were used