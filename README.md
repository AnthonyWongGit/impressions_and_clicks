# impressions_and_clicks

OUTDATED - TODO

Extract data from csv and put it into a dictionary so that the original csv files do not need to be continually read

Adds all UUID as the dictionary key from the impression file

If there is a corresponding click with the same ID in the click file, it can be added by doing a key lookup rather than repeatedly iterating through the entire dictionary. Becomes more important as the data set gets larger.

Made sure to skip reading the header (this one caught me off guard when I was trying to calculate time differences as the cause wasn't obvious)

For each key in the dictionary, if it contained a value 'click', then I would calculate the time and distance differences from the impression by accessing the value of 'impression' and 'click' to retrieve the 'timestamp', 'latitude', and 'longitude' values.

Thought about using comprehension but then it could be a little difficult to read so I stuck with breaking down the variables into multiple lines for easier readability

Used the csv library to read from the csv file, sys to read the arguments in the command line, and h3 to calculate positions

# engagement

Created an SQL file which creates the necessary tables to store the data from the CSV files

Created another SQL file to run queries and return the data required

No additional packages were used