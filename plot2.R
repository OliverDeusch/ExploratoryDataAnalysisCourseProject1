# Read data into R
data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

# Combine Date and Time and convert
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(strptime(data$DateTime, "%d/%m/%Y %H:%M:%S"))

# Convert date into proper dates, Y for 4 digit format
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Extract data between 2007-02-01 and 2007-02-02
library(dplyr)
extracted <- filter(data, Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))


# Convert Global_active_power from factor to number
extracted$Global_active_power <- as.numeric(levels(extracted$Global_active_power))[extracted$Global_active_power]


# Make plot
with(extracted,plot(DateTime, Global_active_power, type ="l", xlab = "", ylab = "Global Active Power (kilowatts)"))


# Save to PNG file
dev.copy(png, file = "plot2.png")
dev.off()
