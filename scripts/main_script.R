# https://github.com/philiphaupt/mpas_in_kent_and_essex.git


# Main scripts
# Read in MPAs, limit to Kent and Essex and transform to UTM31N
source("./scripts/read_mpas.R")


# Make a dissolved MPA layer

# Make a dataframe of the unique names and area size of each
# I have three sf type data frames in a list named mpa_list. I want to apply a function iteratively to each dataframe in the list. I want the function to group and summarise the the sf objects by their name field and work out their collective areas.
source("./scripts/unique_mpas_and_area_size.R")

# Read in KEnt and Essex district boundary polygon in UTM31N
source("./scripts/read_keifca_boundary.R")

# union and intersect MPAs with KEIFCA
file.edit("./scripts/area_mpa_inside_KEIFCA.r")



