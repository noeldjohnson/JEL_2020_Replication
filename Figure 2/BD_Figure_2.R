# Code for Calculating BD Mortality Rate Raster Surface
# Project: JEL Pandemics Symposium
# Created: 6/5/20
# Last Edited: 10/13/20
# Author: Noel D. Johnson
# Notes: This code will create the imputed mortality raster surface for Figure 2 in Jedwab, Johnson, and Koyama "The Economic Impact of the Black Death".

####################################
# global libraries used everywhere #
####################################

mran.date <- "2020-10-13"
options(repos=paste0("https://cran.microsoft.com/snapshot/",mran.date,"/"))



pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
  return("OK")
}

global.libraries <- c("tidyverse", "sf", "haven", "raster", "gstat", "viridis", "tmap")

results <- sapply(as.list(global.libraries), pkgTest)

# library(tidyverse)
# library(sf)
# library(haven)
# library(raster)
# library(gstat)
# library(viridis)
# library(tmap)

setwd("/Users/noeljohnson/Dropbox/Research/Plague City Growth/JEL Symposium/Replication Files/Figure 2/")

# Bring together the data sets you need

# Import and spatialize the data

# Cities
cities_raw <- read_dta("Data/cities274.dta")

# Spatialize the data
# I would usually use Europe Equidistant Conic, but since I need this map to line up with the Nussli data later (for Section 4.4), I project the same as the Nussli maps, in Mercator. For the analysis in Section 4.4, both the grid and the underlying raster and boundary layers will be distorted the same, so this decision should be ok. Remember to change for a more formal analysis in the future.
EEC <- "+proj=eqdc +lat_0=0 +lon_0=0 +lat_1=43 +lat_2=62 +x_0=0 +y_0=0 +ellps=intl +units=m +no_defs"
MERC <- "+proj=merc +lon_0=0 +lat_ts=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"
ALT <- "+proj=merc +lat_0=0 +lon_0=0 +lat_1=43 +lat_2=62 +x_0=0 +y_0=0 +ellps=intl +units=m +no_defs"
cities274 <- st_as_sf(cities_raw, coords=c("longitude", "latitude"), crs=4326) %>% st_transform(MERC) 

sov_boundary_1300 <- st_read("Data/Boundaries1300/sovereign_states.shp") %>% st_transform(MERC)

crs(sov_boundary_1300)
crs(cities274)

# Visualize the data
plot(sov_boundary_1300[6], reset=F)
plot(cities274[5], add=T)

# Make a bounding box of the cities so you can create one a little bigger
bbox_cities <- st_bbox(cities274, crs=MERC)
bbox_cities

xrange <- bbox_cities$xmax - bbox_cities$xmin # range of x values
yrange <- bbox_cities$ymax - bbox_cities$ymin # range of y values
bbox_cities[1] <- bbox_cities[1] - (0.05 * xrange) # xmin - left
bbox_cities[3] <- bbox_cities[3] + (0.05 * xrange) # xmax - right
bbox_cities[2] <- bbox_cities[2] - (0.05 * yrange) # ymin - bottom
bbox_cities[4] <- bbox_cities[4] + (0.05 * yrange) # ymax - top


bbox <- st_make_grid(bbox_cities, n=1)
bbox
plot(sov_boundary_1300[6], col=NA, reset = FALSE)
plot(bbox, add = TRUE)

modern_borders_clip <- st_crop(sov_boundary_1300, bbox)
modern_borders_clip_sp <- as(modern_borders_clip, Class = "Spatial") # Convert from sf to sp
bbox_sp = as(bbox, Class = "Spatial") # Convert from sf to sp
Mort_274_spatial_proj_sp = as(cities274, Class = "Spatial") # Convert from sf to sp

# Create an empty grid where n is the total number of cells
grd              <- as.data.frame(spsample(bbox_sp, "regular", n=50000))
names(grd)       <- c("X", "Y")
coordinates(grd) <- c("X", "Y")
gridded(grd)     <- TRUE  # Create SpatialPixel object
fullgrid(grd)    <- TRUE  # Create SpatialGrid object

# Add modern_borders_clip_sp projection information to the empty grid
proj4string(grd) <- proj4string(modern_borders_clip_sp)

plot(modern_borders_clip_sp, reset = TRUE)
plot(grd, add = TRUE)

## Cross-validation 1

# Estimate the optimal power ("idp") using a cross-validation technique

# Leave-one-out cross-validation routine
step <- 100
res <- 25
IDW.out <- vector(length = length(Mort_274_spatial_proj_sp))
RMSE.out <- vector(length = step)
idw.power <- vector(length = step)

for (j in 1:step) {
  for (i in 1:length(Mort_274_spatial_proj_sp)) {
    IDW.out[i] <- idw(mortality ~ 1, Mort_274_spatial_proj_sp[-i,], Mort_274_spatial_proj_sp[i,], idp=j/res)$var1.pred
  }
  RMSE.out[j] <-  sqrt( sum((IDW.out - Mort_274_spatial_proj_sp$mortality)^2) / length(Mort_274_spatial_proj_sp))
  idw.power[j] <- j/res
}

df <- data.frame(idw.power, RMSE.out)
idw.power.name <- "power"
RMSE.name <- "RMSE"
names(df) <- c(idw.power.name, RMSE.name)

optimal <- df[which.min(df$RMSE),]
optimal

gg <- ggplot(df, aes(x=power, y=RMSE)) +
  geom_point() +
  #geom_smooth(method="loess", se=F) +
  labs(subtitle="Power vs RMSE",
       y="RMSE",
       x="Power")
gg


# Interpolate the grid cells using the optimal power of 1.76 (idp=1.76)
mortality_274_idw <- gstat::idw(mortality ~ 1, Mort_274_spatial_proj_sp, newdata=grd, idp=1.76)


# Convert to raster object then mask
mort_274_raster       <- raster(mortality_274_idw)
mort_274_raster_clip     <- mask(mort_274_raster, modern_borders_clip_sp)

# Plot
tm_shape(mort_274_raster_clip) + 
  tm_raster(n=5,palette = gray(5:0/5), 
            title="Pred. Mortality")  +
  tm_legend(legend.outside=FALSE, legend.position = c(0, 0.35))


# End Code

