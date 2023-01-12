# install package sdm
install.packages("sdm")

library(sdm)
library(raster) # predictors
library(rgdal) # species
library(parallel)

file <- system.file("external/species.shp", package = "sdm") # Report the route to the data

species <- shapefile(file)
plot(species)
species

presences <- species[species$Occurrence == 1,] # you have to use ==, which means =. Also, you need to put the final (,) to finish the argument.
presence$Occurrence

# Exercise: Select the absences
absences <- species[species$Occurrence == 0,]
absences$Occurrence

# plot the presences in blue
plot(presences, col = "blue", pch = 19)

# plot the absences in red
points(absences, col = "red", pch = 19)

# Predictors
path <- system.file("external", package = "sdm")

# list of predictors
lst <- list.files(path = path, pattern = 'asc$', full.names = T) 

# stack
preds <- stack(lst)
plot(preds)

# Model

#set the data for the model
datasdm <- sdmData(train = species, predictors = preds)

m1 <- sdm(Occurrence = elevation + precipitation + temperature + vegetation, data = datasdm, method = "glm")

# make the raster output layer
p1 <- predict(m1, newdata=preds)

# plot the output
plot(p1, col = cl)
points(species{speceies$Occurrence == 1,}, pch = 16)

