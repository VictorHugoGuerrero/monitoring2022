# to install packages, use the function install.packages()
install.packages("raster")

# to access to the packages, use the function library()
library(raster)

# link to our file
# setwd("c:/lab/")

# to import your satellite images, use the function brick()
l2011 <- brick("p224r63_2011_masked.grd")

# to see the image, use the function plot()
plot(l2011)
# B1 is the reflactance in the blue band
# B2 is the reflactance in the green band
# B3 is the reflactance in the red band

# to change the color palette, use the function colorRampPalette()
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011, col = cl)

# to associate the bands to colours, use the function plotRGB(x, r=1, g=2, g=3)
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
