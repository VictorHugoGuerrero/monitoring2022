# Ice melt in Greenland
# Proxy: LST - LAND SURFACE TEMPERATURE (measurement of temperature at the land level)

# Recall packages
library(raster)
library(ggplot2)
library(RStoolbox)
library(patchwork)
setwd("D:/DATA/Desktop/Maestria/Monitoring/Lab/greenland")

# Import the data
rlist <- list.files(pattern = "lst")
rlist

list_raster <- lapply(rlist, raster)
list_raster

lst_stack <- stack(list_raster)
lst_stack

# Plot the data
cl <- colorRampPalette(c("blue", "light blue", "pink", "yellow")) (100)
plot(lst_stack, col = cl)

#ggplot of first and final images 2000 vs 2015
p1 <- ggplot() +
  geom_raster(stack$lst_2000, mapping = aes (x = x, y = y, fill = lst_2000)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("LST in 2000")
p1

p2 <- ggplot() +
  geom_raster(stack$lst_2015, mapping = aes (x = x, y = y, fill = lst_2015)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("LST in 2015")
p2

p1 + p2

# plotting frequency distribution of data
