# Code for the final project for the course: Monitoring Ecosystem Changes and Functioning
# I am going to evaluate the effect of the ENSO over the vegetation cover in the coast of Sudamerica, Peru.

#Recall Packages
library(ncdf4)
library(raster)
library(RStoolbox)
library(viridis)
library(ggplot2)
library(patchwork)

# Set the working directory
setwd("D:/DATA/Desktop/Project")

# Import the data, according to a pattern. In this case the pattern is: FCOVER
rlist <- list.files(pattern = "FCOVER")
rlist

# Apply the raster function over the list of imported data
list_raster <- lapply(rlist, raster)
list_raster

# Stack all the data
fcoverstack <- stack(list_raster)
fcoverstack

# Analyze the imported images. The image is too big for the area I want to work
plot(fcoverstack$Fraction.of.green.Vegetation.Cover.1km.1)

# Crop the images. Instead of cropping one by one, I am going to crop the stack.
# First, I need to stablish the range of the area.
# longitude from -78 to -75
# latitude from -15 to -10
ext <- c(-78, -75.5, -15, -10)
crop_stack <- crop(fcoverstack, ext)
crop_stack

# Assign the layer to an object to compare the images
c1999 <- crop_stack$Fraction.of.green.Vegetation.Cover.1km.4
c1999

c2018 <- crop_stack$Fraction.of.green.Vegetation.Cover.1km.3
c2018

p1 <- ggplot() +
  geom_raster(c1999, mapping = aes(x = x, y = y, fill = Fraction.of.green.Vegetation.Cover.1km.4)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("Vegetation Cover in 1999")
p1

p2 <- ggplot() +
  geom_raster(c2018, mapping = aes(x = x, y = y, fill = Fraction.of.green.Vegetation.Cover.1km.3)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("Vegetation Cover in 2018")

p1 / p2

## Analyze the data about the "warm-phase" (El Niño)------------
# Stack all the data respecting to this phase, including the base image. 
Niño <- stack(crop_stack$Fraction.of.green.Vegetation.Cover.1km.4, 
          crop_stack$Fraction.of.green.Vegetation.Cover.1km.3,
          crop_stack$Fraction.of.green.Vegetation.Cover.1km.2,
          crop_stack$Fraction.of.green.Vegetation.Cover.1km.1)
Niño

# Change the names of the layers
names(Niño) <- c("Neutral", "Low-level", "Medium-level", "High-level")
plot(Niño)

# Histograms of the comparison between these images
pairs(Niño)

## Analyze the data about the "warm-phase" (La Niña)------------
# Stack all the data respecting to this phase, including the base image. 
Niña <- stack(crop_stack$Fraction.of.green.Vegetation.Cover.1km.4, 
              crop_stack$Fraction.of.green.Vegetation.Cover.1km.5,
              crop_stack$Fraction.of.green.Vegetation.Cover.1km.6,
              crop_stack$Fraction.of.green.Vegetation.Cover.1km.7)
Niña

# Change the names of the layers
names(Niña) <- c("Neutral", "Low-level", "Medium-level", "High-level")
plot(Niña)

# Histograms of the comparison between these images
pairs(Niña)

# Difference in vegetation cover between the base image and the high level of the cold phase---------
Niñodif <- Niño$High.level - Niño$Neutral
Niñodif

# Plot the difference
p3 <- ggplot() + 
  geom_raster(Niñodif, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "viridis", direction = -1)
p3

# Difference in vegetation cover between the base image and the high level of the warmer phase---------
Niñadif <- Niña$High.level - Niña$Neutral
Niñadif

# Plot the difference
p4 <- ggplot() + 
  geom_raster(Niñadif, mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "viridis", direction = -1)
p4

p3 + p4

## Estimation of the difference
# Using unsupervised classification with 3 classes

l1999c <- unsuperClass(Niño$Neutral, nClasses = 3)
l1999c
plot(l1999c$map) 

l2015c <- unsuperClass(Niño$High.level, nClasses = 3)
l2015c
plot(l2015c$map) 

l2018c <- unsuperClass(Niña$High.level, nClasses = 3)
l2018c
plot(l2018c$map)

# frequency of the data, and generate frequencies tables
freq(l1999c$map)
#     value  count
#[1,]     1  3387
#[2,]     2 23321
#[3,]     3 59067
#[4,]    NA 71025

freq(l2015c$map)
#     value  count
#[1,]     1  3702
#[2,]     2 39579
#[3,]     3 42494
#[4,]    NA 71025

freq(l2018c$map)
#     value  count
#[1,]     1  3835
#[2,]     2 30000
#[3,]     3 51940
#[4,]    NA 71025

# Neutral
nom <- c("Forest", "Vegetation", "Other") 

Total <- 156800 - 71025
For <- 3387 / Total
Veg <- 23321 / Total
Oth <- 59067 / Total

Base <- c(For, Veg, Oth)

# Niño
For2 <- 3702 / Total
Veg2 <- 39579 / Total
Oth2 <- 42494 / Total

Niño <- c(For2, Veg2, Oth2)

# Niña
For3 <- 3835 / Total
Veg3 <- 30000 / Total
Oth3 <- 51940 / Total

Niña <- c(For3, Veg3, Oth3)
Proportion <- data.frame(nom, Base, Niño, Niña)

p5 <- ggplot(Proportion, aes(x = nom, y = Base, color = nom)) + 
  geom_bar(stat = "identity", fill = "white") + 
  ylim(0, 1) +
  theme(axis.title.x = element_blank())
p6 <- ggplot(Proportion, aes(x = nom, y = Niño, color = nom)) + 
  geom_bar(stat = "identity", fill = "white") + 
  ylim(0, 1) +
  theme(axis.title.x = element_blank())
p7 <- ggplot(Proportion, aes(x = nom, y = Niña, color = nom)) + 
  geom_bar(stat = "identity", fill = "white") + 
  ylim(0, 1) +
  theme(axis.title.x = element_blank())
grid.arrange(p5, p6, p7, nrow = 1)

