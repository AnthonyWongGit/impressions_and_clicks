import sys
import h3
import pandas as pd
import time
import numpy as np

start_time = time.time()

# Script takes 2 arguments which are the names of the impression and click data files
impression_data_name = sys.argv[1]
click_data_name = sys.argv[2]

# Retrieve data from impression_data and add event_id as a key and the remaining data as a value to a dictionary
data_dict = {}

# Read the CSV files into pandas dataframes
df1 = pd.read_csv(impression_data_name)
df2 = pd.read_csv(click_data_name)

# Merge the two dataframes based on the "key" column by left joining impression data with the click data
merged_df = pd.merge(df1, df2, on='event_id', how='inner')

# Calculate average time taken between impression event and click event, as well as average distance between impression event and click event
times_list = []
distances_list = []

for index, row in merged_df.iterrows():
    row_dict = row.to_dict()

    times_list.append(row_dict["timestamp_y"] - row_dict["timestamp_x"])

    impression_position = (row_dict["latitude_x"], row_dict["longitude_x"])
    click_position = (row_dict["latitude_y"], row_dict["longitude_y"])
    distances_list.append(h3.point_dist(click_position, impression_position, unit='m'))

# Convert lists into numpy arrays for quicker calculation
times_array = np.array(times_list)
distances_array = np.array(distances_list)

print(f"Average time between impression and click is {round(np.sum(times_array)/len(times_array)/1000, 2)} second(s)")
print(f"Average distance between impression and click is {round(np.sum(distances_array)/len(distances_array))}m")

end_time = time.time()

elapsed_time = end_time - start_time
print("Elapsed time: ", elapsed_time, "seconds")