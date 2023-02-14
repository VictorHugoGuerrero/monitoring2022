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

