import csv
import sys
import h3

impression_data = sys.argv[1]
click_data = sys.argv[2]

impression_dict = {}

# Retrieve data from impression_data and add event_id as a key and the remaining data as a value to a dictionary
with open(impression_data, newline='') as impression:
    reader = csv.reader(impression, delimiter=' ')
    next(reader, None)
    for row in reader:
        entry = ', '.join(row)
        split_entry = entry.split(',')
        data_to_add = {}

        data_to_add['impression'] = {
            'timestamp': int(split_entry[2]),
            'latitude': split_entry[3],
            'longitude': split_entry[4]
        }

        impression_dict[split_entry[0]] = data_to_add

# Retrieve data from click_data and match event_id in the dictionary then add as a key in the event_id value
with open(click_data, newline='') as click:
    reader = csv.reader(click, delimiter=' ')

    # Skip header
    next(reader, None)
    for row in reader:
        entry = ', '.join(row)
        split_entry = entry.split(',')

        data_to_add = {
            'timestamp': split_entry[1],
            'latitude': split_entry[3],
            'longitude': split_entry[4]
        }

        impression_dict[split_entry[0]]['click'] = data_to_add

# Calculate average time taken between impression event and click event, as well as average distance between impression event and click event
average_times = []
average_distances = []

for key in impression_dict:
    if 'click' in impression_dict[key]:
        timestamp1 = impression_dict[key]['click']['timestamp']
        timestamp2 = impression_dict[key]['impression']['timestamp']
        average_time = int(timestamp1) - int(timestamp2)
        average_times.append(average_time)

        distance1 = (float(impression_dict[key]['click']['latitude']), float(impression_dict[key]['click']['longitude']))
        distance2 = (float(impression_dict[key]['impression']['latitude']), float(impression_dict[key]['impression']['longitude']))
        average_distance = h3.point_dist(distance1, distance2, unit='m')
        average_distances.append(average_distance)


print(f"Average time between impression and click is {sum(average_times)/len(average_times)} second(s)")
print(f"Average distance between impression and click is {round(sum(average_distances)/len(average_distances))}m")