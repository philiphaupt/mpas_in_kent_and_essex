# Names and size of each MPA


library(tidyverse)

calculate_total_area <- function(df_list) {
  results <- list()
  
  for (i in 1:length(df_list)) {
    df <- df_list[[i]]
    
    # Extract the name field and area column based on the dataframe's name
    name_col <- switch(i,
                       MCZ_NAME = "MCZ_NAME",
                       SPA_NAME = "SPA_NAME",
                       SAC_NAME = "SAC_NAME"
    )
    area_col <- switch(i,
                       MCZ_NAME = "MCZ_AREA",
                       SPA_NAME = "SPA_AREA",
                       SAC_NAME = "SAC_AREA"
    )
    
    # Group by the name field and calculate the total area
    total_area <- df %>%
      group_by(!!sym(name_col)) %>%
      summarize(Total_Area = sum(!!sym(area_col))) %>%
      ungroup()
    
    results[[i]] <- total_area
  }
  
  return(results)
}

# Call the function with your list of data frames
mpa_areas <- calculate_total_area(mpa_list)

names(mpa_areas) <- c("mcz", "spa", "sac")
#------------------
library(dplyr)
library(sf)
library(stringr)

# df_list <- mpa_list
# #df <- df_list[[1]]
# i = 1

calculate_total_area_and_save <- function(df_list, output_file) {
  results <- list()
  
  for (i in 1:length(df_list)) {
    df <- df_list[[i]]
    
    # Drop the geometry field
    df <- df %>%
      st_drop_geometry()
    
    # Extract the name field and area column based on the dataframe's name
    name_col <- switch(i,
                       MCZ_NAME = "MCZ_NAME",
                       SPA_NAME = "SPA_NAME",
                       SAC_NAME = "SAC_NAME"
    )
    
    # Add an "mpa_type" column based on the first three letters of the name column header
    df <- df %>%
      mutate(mpa_type = str_sub(name_col, start = 1, end = 3))
    
    # Create a common "mpa_name" column by combining all the name fields
    df <- df %>%
      rowwise() %>%
      mutate(mpa_name = toString(c_across(first(ends_with("NAME"))))
      ) %>%
      ungroup()
    

    area_col <- switch(i,
                       MCZ_NAME = "MCZ_AREA",
                       SPA_NAME = "SPA_AREA",
                       SAC_NAME = "SAC_AREA"
    )
    

    
    # Group by the "name_col" field and calculate the total area
    total_area <- df %>%
      group_by(mpa_name) %>%
      summarize(Total_Area = sum(!!sym(area_col))) %>%
      ungroup()
    
    # Add the "mpa_type" and "mpa_name" fields back to the dataframe
    total_area <- total_area %>%
      mutate(
        mpa_type = unique(df$mpa_type),
        mpa_name = unique(df$mpa_name)
      )
    
    
    # Add the result to the list
    results[[i]] <- total_area
  }
  
  # Combine the results into a single data frame
  combined_df <- bind_rows(results)
  
  # Select the desired columns
  combined_df <- combined_df %>%
    select(mpa_name, mpa_type, Total_Area)
  
  # Save the result to a CSV file
  write.csv(combined_df, output_file, row.names = FALSE)
}

calculate_total_area_and_save(mpa_list, "./outputs/mpa_name_and_size.csv")

