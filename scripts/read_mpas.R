# read_mpas
library(tidyverse)
library(sf)
library(data.table)

# read in - note all utm31n
spa_utm31n <- read_sf("C:/Users/Phillip Haupt/Documents/GIS/gis_data/MPAs/MPAs_England.gpkg",layer="SPAs_England_WGS84") %>% 
  dplyr::filter(intersects_keifca %in% c("yes", "Yes")) %>% st_transform(crs = 32631)
  

mcz_utm31n <- read_sf("C:/Users/Phillip Haupt/Documents/GIS/gis_data/MPAs/MPAs_England.gpkg",layer="MCZs_England_WGS84")  %>% 
  dplyr::filter(district %in% c("Kent", "Essex"))%>% st_transform(crs = 32631)

sac_utm31n <- read_sf("C:/Users/Phillip Haupt/Documents/GIS/gis_data/MPAs/MPAs_England.gpkg",layer="SACs_England_WGS84") %>% 
  dplyr::filter(intersects_keifca %in% c("yes", "Yes"))%>% st_transform(crs = 32631)

#make a collective MPA list
mpa_list = list(mcz_utm31n,spa_utm31n,sac_utm31n)
names(mpa_list) <- c("mcz", "spa", "sac")
