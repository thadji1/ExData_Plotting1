# This script is related to the course project 1 of Coursera
# 'Exploratory Data Analysis' course (week 1).
# The objective is to use basic plotting system to make 4 plots
# and to save them into 4 png files

# This first script is to make plot1 which is a histogram with
# the frequency of global active power

#load dplyr package
library(dplyr)

# Reading data
elec1 <- read.table(file = "./Data/household_power_consumption.txt",
                    header = TRUE, sep = ";", colClasses = "character")

# Filtering on 1/2/2007 and 2/2/2007
elec <- elec1[grep("^[12]/2/2007", elec1$Date), ]

# Convert to numeric
elec <- mutate(elec, Global_active_power = as.numeric(Global_active_power))

# Open png file, make graph and close the file
png(filename = "./Output/plot1.png", width = 480, height = 480)
hist(elec$Global_active_power, main = "Global Active Power",
                xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

