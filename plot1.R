# Read data into R
data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

# Convert date into proper dates, Y for 4 digit format
data$Date <- as.Date(data$Date, "%d/%m/%Y")


# Extract data between 2007-02-01 and 2007-02-02
library(dplyr)
extracted <- filter(data, Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))


# Convert Global_active_power from factor to number
extracted$Global_active_power <- as.numeric(levels(extracted$Global_active_power))[extracted$Global_active_power]


# Make plot
hist(extracted$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")


# Save to PNG file
dev.copy(png, file = "plot1.png")
dev.off()

