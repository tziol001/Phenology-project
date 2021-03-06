# Authors: Nikoula Team, Latifah and Nikos
# Date: 27/1/2015

# Function to create a raster stack using subset MODIS data

# Description: Automatically creates the extent of the selected flux towers and returns a georefernced raster stack.

# parameter (type, description)

# df (data.frame, Takes as input the data frame that is resulted from ModisSubset function)
# site (Character, It can be one of the flux towers from around the world)

modisRaster <-
  function(df, site)
  {
    Sites_info <- read.csv("data/MODIS_Subset_Sites_Information.csv")

    pos <- which(Sites_info$Site_Name == site) # find the row in which the selected fluwtower station is existed

    # create the extent, (xmin, xmax, ymin, ymax), by looking at modis subset info data frame. Further informations can be found in: http://daac.ornl.gov/cgi-bin/MODIS/GR_col5_1/mod_viz.html    
      extent <- extent(Sites_info$NW_Longitude_edge[pos], Sites_info$SE_Longitude_edge[pos], Sites_info$SE_Latitude_edge[pos], Sites_info$NW_Latitude_edge[pos])
    
    # the site coordinates are projected in lat/long
    latlong <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
    ## convert these to sinusoidal projection
    modissin <- 
      "+proj=sinu +lon_0=0 +x_0=0 +y_0=0+a=6371007.181 +b=6371007.181+units=m +no_defs"
    
    # convert the df to rasters by using the df2raster function
    rasters <- apply(X=df, 1, FUN=df2raster)
    
    # create the stack of the rasters
    stack <- stack(rasters)
    
    # project the stack
    projection(stack)<-latlong
    
    # use the extent in the raster layer
    stack <- setExtent(stack, extent, keepres=FALSE, snap=FALSE)
        
  return(stack)
  }