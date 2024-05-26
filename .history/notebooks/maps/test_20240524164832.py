# Correcting the code to properly handle the multi-line string for the DataFrame iteration and marker creation

import nbformat as nbf
# Create a new Jupyter Notebook
nb = nbf.v4.new_notebook()

# Add cells to the notebook
nb['cells'] = [
    nbf.v4.new_markdown_cell("## Visualizing Incident Data on Interactive Maps with Folium"),
    nbf.v4.new_markdown_cell("### Introduction\n\nInteractive maps are powerful tools for visualizing geographical data. In this blog post, we will explore how to use the Folium library in Python to create interactive maps that display incident data. Folium is a powerful library that makes it easy to visualize data that’s been manipulated in Python on an interactive leaflet map."),
    nbf.v4.new_markdown_cell("### Setting Up\n\nBefore we dive into the code, make sure you have Folium installed. You can install it using pip:\n\n```bash\npip install folium\n```"),
    nbf.v4.new_markdown_cell("### Creating a Map with Incident Data\n\nLet's start by creating a simple interactive map. We'll use Folium to plot incident data, which includes details such as the date of the incident, crew members involved, and specific details of the incident. Here’s a step-by-step guide on how to achieve this:"),
    nbf.v4.new_markdown_cell("#### 1. Importing Libraries and Data\n\nFirstly, we need to import the necessary libraries and read the data into a pandas DataFrame.\n\n```python\nimport folium\nfrom folium.plugins import MarkerCluster\nimport pandas as pd\n\n# Assuming df_filtered is our DataFrame containing incident data\ndf_filtered = pd.read_csv('incident_data.csv')\n```"),
    nbf.v4.new_markdown_cell("#### 2. Initializing the Map\n\nWe'll create a base map centered at a specific latitude and longitude.\n\n```python\n# Initialize the map at a certain location\nm = folium.Map(location=[56.0, -4.5], zoom_start=7)\n```"),
    nbf.v4.new_markdown_cell("#### 3. Adding Marker Clusters\n\nTo manage a large number of markers efficiently, we use Marker Clusters.\n\n```python\n# Use marker clusters for incidents\nmarker_cluster = MarkerCluster().add_to(m)\n```"),
    nbf.v4.new_markdown_cell("""#### 4. Mapping Incident Data\n\nNext, we iterate through each row of the DataFrame and add markers to the map with popups and tooltips that provide additional information about each incident.\n\n```python
# Define color mapping for pager codes
color_mapping = {222: "green", 333: "orange", 999: "red"}

# Iterate through each row of df_filtered
for index, row in df_filtered.iterrows():
    lat = row["latitude"]
    lng = row["longitude"]
    descrip = f"{row['date_of_shout']}\\nCrew on board: {row['crew_on_board']}\\nCrew on shore: {row['crew_on_shore']}\\nShout tags: {row['shout_details_tags']}"
    details = f"Shout details:\\n{row['shout_details']}"
    
    # Add incident marker to the marker cluster
    folium.Marker(
        location=[lat, lng],
        tooltip=descrip,
        popup=folium.Popup(details, max_width=300),
        icon=folium.Icon(color=color_mapping[row['pager_code']]),
    ).add_to(marker_cluster)
```"""),
    nbf.v4.new_markdown_cell("#### 5. Displaying the Map\n\nFinally, we return and display the map.\n\n```python\n# Display the map\nm\n```"),
    nbf.v4.new_markdown_cell("### Conclusion\n\nWith just a few lines of code, you can create an interactive map that provides valuable insights into your geographical data. Folium, combined with the power of Python, offers a flexible and efficient way to visualize incident data on maps.\n\nFeel free to explore more features of Folium to enhance your maps, such as adding different layers, customizing markers, and incorporating other plugins. Happy mapping!")
]

# Save the notebook to a file
notebook_path = 'folium_map_blog_post.ipynb'
with open(notebook_path, 'w') as f:
    nbf.write(nb, f)

notebook_path
