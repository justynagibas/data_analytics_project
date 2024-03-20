import folium
import pandas as pd
import ast

df_routes = pd.read_csv('routes2.csv', delimiter=',')
df_clusters = pd.read_csv('clusters.csv', delimiter=',')

df_routes = df_routes.merge(df_clusters, on="Og-data-row-number", how='inner')

routes = df_routes[['Route-coordinates', 'cluster_n']]
clusters = df_routes['cluster_n']
unique_clusters = clusters.unique()
center_eendia_point = (21.9149, 78.0281)

# Create a map centered around the start point
mymap = folium.Map(location=center_eendia_point, zoom_start=6, prefer_canvas=True)

for cluster in unique_clusters:
    cluster_routes = routes[routes['cluster_n'] == cluster]['Route-coordinates']
    cluster_layer = folium.FeatureGroup(name=f'Cluster {cluster}', show=False)
    for str_route in cluster_routes:
        route_coordinates = ast.literal_eval(str_route)
        folium.PolyLine(locations=route_coordinates, color='rgba(255, 0, 255, 0.1)', weight=3).add_to(cluster_layer)
    cluster_layer.add_to(mymap)

# Add layer control to the map
folium.LayerControl().add_to(mymap)

# Save the map to an HTML file
mymap.save("test_multi_layer_map.html")