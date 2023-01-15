# Time series of NO2 change in Europe during the lockdown

library(raster)

setwd("D:/DATA/Desktop/Maestria/Monitoring/Lab/EN")

# To import the data, we're going to use the function brick() because we have single data.In this case, we are going to use the function raster().
en01 <- raster("EN_0001.png")

# plot the NO23 values of January 2020 by the "cl" palette
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(en01, col = cl)

# Exercise: Import the end of March NO2 and plot it
en13 <- raster("EN_0013.png")
en13
plot(en13, col=cl)

# Build a multiframe window with 2 rows and 1 column with par()
par(mfrow = c(2,1))
plot(en01, col = cl)
plot(en13, col=cl)

# import all the images
en01 <- raster("EN_0001.png")
en02 <- raster("EN_0002.png")
en03 <- raster("EN_0003.png")
en04 <- raster("EN_0004.png")
en05 <- raster("EN_0005.png")
en06 <- raster("EN_0006.png")
en07 <- raster("EN_0007.png")
en08 <- raster("EN_0008.png")
en09 <- raster("EN_0009.png")
en10 <- raster("EN_0010.png")
en11 <- raster("EN_0011.png")
en12 <- raster("EN_0012.png")
en13 <- raster("EN_0013.png")

#plot all the data together
par(mfrow = c(4,4))
plot(en01, col = cl)
plot(en02, col = cl)
plot(en03, col = cl)
plot(en04, col = cl)
plot(en05, col = cl)
plot(en06, col = cl)
plot(en07, col = cl)
plot(en08, col = cl)
plot(en09, col = cl)
plot(en10, col = cl)
plot(en11, col = cl)
plot(en12, col = cl)
plot(en13, col = cl)

# make a stack, instead of using plot, to plot the 13 images.
EN <- stack(en01, en02, en03, en04, en05, en06, en07, en08, en09, en10, en11, en12, en13)

# Plot only the first image of the stack
# Check the names of the layers
plot(EN$layer.1)

#PlotRGB
plotRGB(EN, r = 1, g = 7, b = 13, stretch = "lin")

----------------------------------------------------------------------Day 2------------------------------------------

library(raster)

setwd("D:/DATA/Desktop/Maestria/Monitoring/Lab/EN")

# Import all the data together, without doing it one by one.
# lapply is a function that gives a function to a list or to a vector. So to use this function it is required to create a list first of all
rlist <- list.files(pattern = "EN")
rlist

list_rast <- lapply(rlist, raster)

#Now that the files were imported, we need to stack them together
EN_stack <- stack(list_rast)
EN_stack

# plot the stack by the "cl" palette
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(EN_stack, col = cl)

# Exercise: plot the first image of the stack
plot(EN_stack$layer.1, col = cl)

# difference
ENdif <- EN_stack$layer.1 -EN_stack$layer.13
cldif <- colorRampPalette(c("blue", "white", "red"))(100)
plot(ENdif, col = cldif)

# automated processing source function
# do it in Notepad, and save it without extension (.txt)
source("R_code_automatic_script.txt")

