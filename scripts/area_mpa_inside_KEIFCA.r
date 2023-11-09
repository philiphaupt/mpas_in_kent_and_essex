library(sf)


#creat 
mpa <- purrr::map(mpa_list, st_union)

# Perform a spatial intersection with KEIFCA_utm31
intersection <- st_intersection(mpa, KEIFCA_utm31)

# Calculate the total area of the resulting objects
total_area <- st_area(intersection) %>% sum(na.rm = TRUE)

# Print the total area
cat("Total area:", total_area, "square units\n")

