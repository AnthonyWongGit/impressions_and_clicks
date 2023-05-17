# impressions_and_clicks

Ensure that you have set up a virtual environment and installed the requirements from the requirements.txt file by typing the following into the command line (command syntax may vary depending on system):

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

Then to run the script, type the following into the command line:

python3 src/impression_click.py data/impression_data.csv data/click_data.csv

This will output the average time and distance between all impressions and their corresponding click (if applicable)

The script uses pandas, h3, sys, and time modules to complete the calculations. These were used for the following purposes:
    * pandas - reads the csv as a dataframe and performs inner on the impression dataframe against the click dataframe
    * h3 - calculates distances given latitude and longitude values
    * sys - allows flexibility for naming the csv files
    * time - calculates the time taken to run the script
    * numpy - converts list into numpy array for faster calculations

The csv files are first read using the pandas read csv, and stores them as a dataframe. An inner join is performed to match against impressions which have a corresponding click. This will discard rows with no match.

For each row in the newly merged dataframe, the time difference is calculated by subtracting the click timestamp against the impression timestamp, and then adding it to a time list. The distance is also calculated using the h3 module, by taking the latitude/longitude values of the impression and click, taking the distance, and then finally adding it to a distance list.

The lists are converted into a numpy array. The results are printed by taking the average value of the arrays, and formatting it into the correct unit of measurement.

# engagement

You must ensure that your psql database is online. Also ensure that you have already followed the setup instructions from earlier for the virtual environment. Then, you need to run the initialisation script by typing the following into the command line:

psql -f src/init_dataset.sql

Then you have 2 options which is to either run the (old) sql file or the newer, more optimised python script containing sql commands. To run the (old) sql file, simply type the following into the command line:

psql -f src/query_dataset.sql

This will return a text and a table of KPIs for each asset.

If you wish to run the python script then you need to ensure that the credentials in the db_credentials.json match your psql credentials by filling in the blank username and password fields. Then, type the following into the command line:

python3 src/query_dataset.py

This will return strings and dictionaries containing KPIs for each asset.