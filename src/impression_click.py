import sys
import h3
import pandas as pd
import time
import numpy as np
import folium
from folium.plugins import HeatMap

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

# Create a folium map with markers
marker_map = folium.Map(location=(54, -5), zoom_start=6, tiles="cartodb positron")

for i, row in merged_df.iterrows():
    lat = merged_df.at[i, 'latitude_x']
    lng = merged_df.at[i, 'longitude_x']
    impression_position = (merged_df.at[i, 'latitude_x'], merged_df.at[i, 'longitude_x'])
    click_position = (merged_df.at[i, 'latitude_y'], merged_df.at[i, 'longitude_y'])
    dst_to_click = h3.point_dist(click_position, impression_position, unit='m')

    popup = f'Location {lat},{lng}'

    marker_color = 'red'

    if dst_to_click < 500:
        marker_color = 'lightblue'
    elif dst_to_click < 1000:
        marker_color = 'blue'
    elif dst_to_click < 1500:
        marker_color = 'cadetblue'
    elif dst_to_click < 2000:
        marker_color = 'orange'

    folium.Marker(location = [lat, lng], popup=popup, icon = folium.Icon(color=marker_color)).add_to(marker_map)

marker_map.save("folium_marker_map.html")

# Create a folium heat map
heat_map = folium.Map(location=(54, -5), zoom_start=6.5, tiles="cartodb positron")

merged_df['latitude_x'] = merged_df['latitude_x'].astype(float)
merged_df['longitude_x'] = merged_df['longitude_x'].astype(float)

heat_df = merged_df[['latitude_x', 'longitude_x']]

heat_data = [[row['latitude_x'], row['longitude_x']] for index, row in heat_df.iterrows()]

HeatMap(heat_data).add_to(heat_map)

heat_map.save("folium_heat_map.html")

end_time = time.time()

elapsed_time = end_time - start_time
print("Elapsed time: ", elapsed_time, "seconds")