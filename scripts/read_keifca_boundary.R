# read in KEIFCA boundary
library(sf)
sf::st_layers("C:/Users/Phillip Haupt/Documents/GIS/gis_data/6M_12M_from_territorial_sea_baseline_5_Jun_20_and_1983/KEIFCA_6NM.GPKG")
KEIFCA_utm31 <- st_read("C:/Users/Phillip Haupt/Documents/GIS/gis_data/6M_12M_from_territorial_sea_baseline_5_Jun_20_and_1983/KEIFCA_6NM.GPKG",  layer = "KEIFCA_6NM_district_1983_baseline_simplified") %>% st_as_sf()
# create convex hull - for simplifying geometric operations.
# KEIFCA_convex_hull_utm31 <- st_convex_hull(KEIFCA_utm31)
# 
# # transform to WGS84
# KEIFCA_convex_hull_wgs84 <- st_transform(KEIFCA_convex_hull_utm31, 4326)

#rm(KEIFCA_utm31, KEIFCA_convex_hull_utm31)