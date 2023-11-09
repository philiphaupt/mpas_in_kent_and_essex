library(sf)

#create dissolved mpa layer
mpa <- purrr::map(mpa_list, st_union)
mpas_dis <- st_union(mpa[[1]], mpa[[2]]) %>% st_union(mpa[[3]])
ggplot()+
  geom_sf(data = mpas_dis, aes(alpha = 0.3))

# Perform a spatial intersection with KEIFCA_utm31
intersection <- st_intersection(mpas_dis, KEIFCA_utm31)
ggplot()+
  geom_sf(data = intersection, aes(alpha = 0.3))

st_write(intersection, "./outputs/intersection_keifca_dissolved_mpas.gpkg", layer = "MPA coverage")
# Calculate the total area of the resulting objects
total_area <- st_area(intersection) %>% sum(na.rm = TRUE)

# Print the total area
cat("Total area:", total_area/1000000, "square km\n")

