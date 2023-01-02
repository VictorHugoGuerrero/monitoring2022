# This is my first code in github!

# Here are the input data
#costanza data on streams
water <- c(100, 200, 300, 400, 500)
water

# Marta data on fishes genomes
fishes <- c(10, 50, 60, 100, 200)
fishes

# plot(x,y) <- x = independent, y = dependent
plot(water, fishes)

# to create a table, you need to create dataframe using the function data.frame()
data.frame(water, fishes)

# to export the table, you use write.table()
write.table(streams, file="my_first_table.txt")

# to read a table that someone sent it to you, you use the function read.table()
read.table("my_first_table.txt")

# assign a name to the table inside R
victortable <- read.table("my_first_table.txt")

# to create a statistics summary, you use the function summary()
summary(victortable) # with this function you get: min, max, mean, and quartiles

# to get the summary of only one variable
summary(victortable$fishes)

# to do an histogram, use the function hist()
hist(victortable$fishes)
hist(victortable$water)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
# <- it is use to asigne names to objects
# plot(x, y) is the function to make graphs 
plot(miriam, victoria)

#ask about the function
?plot

# the argument pch is use to modify the shape of the points in the graphs
plot(miriam, victoria, pch = 15)

# the argument col is to modify the colour of the points
plot(miriam, victoria, pch = 15, col = "blue")

# the argument cex is to modify the size of the points
plot(miriam, victoria, pch = 15, col = "blue", cex = 3)

------------------------------------------------------------------------------------------------------------------------------

primates <- c(3, 5, 9, 15, 40)
primates

crabs <- c(100, 70, 30, 10, 5)
crabs

plot(primates, crabs)
plot(primates, crabs, col = "red")
plot(primates, crabs, col = "red", pch = 19)
plot(primates, crabs, col = "red", pch = 19, cex = 2)
plot(primates, crabs, col = "red", pch = 19, cex = 6)
plot(primates, crabs, col = "red", pch = 19, cex = 6, main = "My first ecological graph in R!")

----------------------------------------------------------------------------------------------------------------------------------------------------------


