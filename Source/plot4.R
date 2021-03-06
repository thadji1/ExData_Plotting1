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
elec <- mutate(elec,
               Sub_metering_1 = as.numeric(Sub_metering_1),
               Sub_metering_2 = as.numeric(Sub_metering_2),
               Sub_metering_3 = as.numeric(Sub_metering_3))
elec <- mutate(elec, Voltage = as.numeric(Voltage))
elec <- mutate(elec, Global_reactive_power = as.numeric(Global_reactive_power))

# Convert Date and Time
elec <- mutate (elec, NewTime = as.POSIXct(strptime(x = paste(Date, Time),
                format = "%d/%m/%Y %H:%M:%S")))

# Open png file, make graph and close the file
png(filename = "./Output/plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

#plot1
plot(elec$NewTime, elec$Global_active_power, xlab ="",
     ylab = "Global Active Power", type = "l")

#plot2
plot(elec$Voltage ~ elec$NewTime, xlab = "datetime", ylab = "Voltage", type = "l")

#plot3
plot(elec$Sub_metering_1 ~ elec$NewTime, xlab ="",
                ylab = "Energy sub metering", type = "l")
lines(elec$Sub_metering_2 ~ elec$NewTime, col = "red")
lines(elec$Sub_metering_3 ~ elec$NewTime, col = "blue")
legend("topright", col = c("black", "red", "blue"),
                legend = c("Sub_metering_1", "Sub_metering_2",
                           "Sub_metering_3"), lty = 1)

#plot4
with(elec, plot(Global_reactive_power ~ NewTime, xlab = "datetime", type = "l"))

dev.off()


