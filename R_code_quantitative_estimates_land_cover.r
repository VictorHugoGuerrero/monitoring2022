library(raster)
library(RStoolbox) # we will you this package to make the classification
library(ggplot2) # we will use this package for the ggplot function
library(gridExtra) # we will use this package for multiframe ggplot

setwd("D:/DATA/Desktop/Maestria/Monitoring/Lab")

# brick
# 1 list the files available
rlist <- list.files(pattern = "defor")
rlist

# 2 lapply: apply a function to a list
# we use the brick function because each image is composed by three bands
list_rast <- lapply(rlist, brick)
list_rast

# name each image
l1992 <- list_rast[[1]]
l1992

l2006 <- list_rast[[2]]
l2006

# defor bands:  NIR = 1, red = 2, green = 3

plotRGB(l1992, r = 1, g = 2, b = 3, stretch = "lin")
plotRGB(l2006, r = 1, g = 2, b = 3, stretch = "lin")

# use a clasiffication to notice which parts are forests and which one are agricultural areas, Unsupervised classification.
l1992c <- unsuperClass(l1992, nClasses = 2)
l1992c
plot(l1992c$map)
# value 1 = agricultural areas and water
# value 2 = forests

# frequency of the data, and generate frequencies tables
freq(l1992c$map)

#     value  count
#[1,]     1  35183
#[2,]     2 306109

total <- 341292
propforest <- 306109/total
propagri <- 35183/total

# agricultural and water: 0.1030877 ~ 0.10
# forest: 0.8969123 ~ 0.90

# bulid a dataframe
cover <- c("Forests", "Agriculture")
# prop1992 <- c(0.8969123, 0.1030877)
prop1992 <- c(propforest, propagri)
proportion1992 <- data.frame(cover, prop1992)
proportion1992

# plot the barchart of 1992, with the proportion found it before
ggplot(proportion1992, aes(x = cover, y = prop1992,  color = cover)) + geom_bar(stat = "identity", fill = "white")

# classification of 2006
l2006c <- unsuperClass(l2006, nClasses = 2)
l2006c
plot(l2006c$map)
# value 1 = agricultural areas and water
# value 2 = forests

# frequency of 2006
freq(l2006c$map)

#    value  count
#[1,]     1 163591
#[2,]     2 179135

total2 <- 342726
propforest2 <- 179135/total
propagri2 <- 163591/total

# agricultural and water: 0.4793286 ~ 0.48
# forest: 0.5248731 ~ 0.52

# bulid a dataframe
prop2006 <- c(propforest2, propagri2)
proportion2006 <- data.frame(cover, prop2006)
proportion2006

proportion <- data.frame(cover, prop1992, prop2006)

# plot the barchart of 2006 with the proportion found before
ggplot(proportion2006, aes(x = cover, y = prop2006,  color = cover)) + geom_bar(stat = "identity", fill = "white")

# plot all together
p1 <- ggplot(proportion1992, aes(x = cover, y = prop1992,  color = cover)) + geom_bar(stat = "identity", fill = "white") + ylim(0, 1)
p2 <- ggplot(proportion2006, aes(x = cover, y = prop2006,  color = cover)) + geom_bar(stat = "identity", fill = "white") + ylim(0, 1)
grid.arrange(p1, p2, nrow = 1)



