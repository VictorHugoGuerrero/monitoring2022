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
# B4 is the reflactance in the NIR band

# to change the color palette, use the function colorRampPalette()
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011, col = cl)

# to associate the bands to colours, use the function plotRGB(x, r=1, g=2, g=3)
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")

------------------------------------------------ Day 2------------------------------------------------------------

# To plot only one band, use the function plot(), but you need to use the argument ($) to specify the band you want to plot.
plot(l2011$B2_sre) # green band

# to change the color palette, use the function colorRampPalette() 
#the first colour represents the value for objects that absorbs completely the colour of the band, and the third one represents the objects that reflect completely the colour in the band
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011$B2_sre, col = cl)

# Exercise 1: change the colorRampPalette with dark green, green, and light green, e.g. clg
clg <- colorRampPalette(c("dark green", "green", "light green"))(100)
plot(l2011$B2_sre, col = clg)

# Exercise 2: change the colorRampPalette with dark blue, blue, and light blue, e.g. clg
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(l2011$B1_sre, col = clb)

# to plot two images in just one multiframe graph, use the function par() stablishing the order of the graph you want
par(mfrow = c(1,2))
plot(l2011$B1_sre, col = clb)
plot(l2011$B2_sre, col = clg)

# Exercise 1: plot both images in just one multiframe graph with 2 rows and just 1 column
par(mfrow = c(2,1))
plot(l2011$B1_sre, col = clb)
plot(l2011$B2_sre, col = clg)
