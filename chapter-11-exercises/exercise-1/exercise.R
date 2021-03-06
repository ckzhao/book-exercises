# Exercise 1: working with data frames (review)
install.packages("dplyr")
library("dplyr")

# Install devtools package: allows installations from GitHub
install.packages("devtools")

# Install "fueleconomy" dataset from GitHub
devtools::install_github("hadley/fueleconomy")

# Use the `libary()` function to load the "fueleconomy" package
library(fueleconomy)

# You should now have access to the `vehicles` data frame
# You can use `View()` to inspect it
colnames(vehicles)
View(vehicles)

# Select the different manufacturers (makes) of the cars in this data set. 
# Save this vector in a variable
makes <- vehicles$make

# Use the `unique()` function to determine how many different car manufacturers
# are represented by the data set
length(unique(makes))

# Filter the data set for vehicles manufactured in 1997
vehicles_1997 <- vehicles[vehicles$year == 1997, ]

# Arrange the 1997 cars by highway (`hwy`) gas milage
# Hint: use the `order()` function to get a vector of indices in order by value
# See also:
# https://www.r-bloggers.com/r-sorting-a-data-frame-by-the-contents-of-a-column/
order(vehicles_1997, decreasing = TRUE)

# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
vehicles_1997$average <- (vehicles_1997$hwy + vehicles_1997$cty)/2

# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. 
# Save this new data frame in a variable.
vehicles_2wd <- vehicles[vehicles$drive == "2-Wheel Drive", ]
efficent_2wd <- vehicles_2wd[vehicles_2wd$cty > 20, ]
print(efficent_2wd)

# Of the above vehicles, what is the vehicle ID of the vehicle with the worst 
# hwy mpg?
# Hint: filter for the worst vehicle, then select its ID.
vehicles_2wd[vehicles_2wd$hwy == min(vehicles_2wd$hwy), "id"]

vehicles_2wd$id
vehicles_2wd$hwy

# Write a function that takes a `year_choice` and a `make_choice` as parameters, 
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles 
# of that make in that year.
# You'll need to filter more (and do some selecting)!
filter_vehicle <- function(year_choice, make_choice){
  vehicles_year_make <- vehicles[vehicles$year == year_choice & vehicles$make == make_choice, ]
  most_mg <- vehicles_year_make[vehicles_year_make$hwy == max(vehicles_year_make$hwy), "model"]
  print(most_mg)
}
# What was the most efficient Honda model of 1995?
filter_vehicle(1995, "Honda")
