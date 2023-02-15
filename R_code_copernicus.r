# R code for uploading and visualizing copernicus data in R

# Install packages needed
install.packages("ncdf4")

# Recall packages
library(ncdf4)
library(raster)

# Set the working directory
setwd("D:/DATA/Desktop/Maestria/Monitoring/Lab/copernicus")

#Import the data from the file
fcover19990801 <- raster("c_gls_FCOVER_199909300000_GLOBE_VGT_V2.0.2.nc")
fcover19990801

plot(fcover19990801)

---------------------------------------------------DAY 2-----------------------------------------------------------

# Install packages
install.packages("viridis")

# Recall packages
library(ncdf4)
library(raster)
library(RStoolbox)
library(viridis)
library(ggplot2)
library(patchwork)

# Set the working directory
setwd("D:/DATA/Desktop/Maestria/Monitoring/Lab/copernicus")

# List the images you are going to use in the project
rlist <- list.files(pattern = "FCOVER")
rlist

list_raster <- lapply(rlist, raster)
list_raster

fcoverstack <- stack(list_raster)
fcoverstack

# Assign simple names to the files
c2018 <- fcoverstack$Fraction.of.green.Vegetation.Cover.1km.1
c2018

c1999 <- fcoverstack$Fraction.of.green.Vegetation.Cover.1km.2
c1999

# Plot the image with viridis
# in fill you have to put the name of your variable,as it is in the layer
p1 <- ggplot() +
  geom_raster(c1999, mapping = aes(x = x, y = y, fill = Fraction.of.green.Vegetation.Cover.1km.2)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("Vegetation Cover in 1999")

p2 <- ggplot() +
  geom_raster(c2018, mapping = aes(x = x, y = y, fill = Fraction.of.green.Vegetation.Cover.1km.1)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("Vegetation Cover in 2018")

# patchwork package
p1 / p2

# Crop the image
# longitude from -80 to -60
# latitude from 0 to -20
ext <- c(-80, -60, 0, -20)
crop_1999 <- crop(c1999, ext)
crop_2018 <- crop(c2018, ext)

# It is possible to crop all the images, selecting the stack
#crop_stack <- crop(fcoverstack, ext)
