import csv
import sys
import h3

# Script takes 2 arguments which are the names of the impression and click data files
impression_data_name = sys.argv[1]
click_data_name = sys.argv[2]

# Retrieve data from impression_data and add event_id as a key and the remaining data as a value to a dictionary
data_dict = {}

with open(impression_data_name, newline='') as impression:
    reader = csv.reader(impression, delimiter=' ')
    next(reader, None)

    for row in reader:
        entry = ', '.join(row)
        split_entry = entry.split(',')
        data_to_add = {}

        data_to_add['impression'] = {
            'timestamp': split_entry[2],
            'latitude': split_entry[3],
            'longitude': split_entry[4]
        }

        data_dict[split_entry[0]] = data_to_add

# Retrieve data from click_data and match event_id in the dictionary then add as a key in the event_id value
with open(click_data_name, newline='') as click:
    reader = csv.reader(click, delimiter=' ')
    next(reader, None)

    for row in reader:
        entry = ', '.join(row)
        split_entry = entry.split(',')

        data_to_add = {
            'timestamp': split_entry[1],
            'latitude': split_entry[3],
            'longitude': split_entry[4]
        }

        data_dict[split_entry[0]]['click'] = data_to_add

# Calculate average time taken between impression event and click event, as well as average distance between impression event and click event
impression_click_times = []
impression_click_distances = []

for key in data_dict:
    if 'click' in data_dict[key]:
        click_timestamp = data_dict[key]['click']['timestamp']
        impression_timestamp = data_dict[key]['impression']['timestamp']
        time_difference = int(click_timestamp) - int(impression_timestamp)
        impression_click_times.append(time_difference)

        click_position = (float(data_dict[key]['click']['latitude']), float(data_dict[key]['click']['longitude']))
        impression_position = (float(data_dict[key]['impression']['latitude']), float(data_dict[key]['impression']['longitude']))
        distance = h3.point_dist(click_position, impression_position, unit='m')
        impression_click_distances.append(distance)

# Finally print out the required data
print(f"Average time between impression and click is {sum(impression_click_times)/len(impression_click_times)} second(s)")
print(f"Average distance between impression and click is {round(sum(impression_click_distances)/len(impression_click_distances))}m")