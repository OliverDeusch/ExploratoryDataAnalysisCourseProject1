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


# Convert meter data from factor to number
extracted$Sub_metering_1 <- as.numeric(levels(extracted$Sub_metering_1))[extracted$Sub_metering_1]
extracted$Sub_metering_2 <- as.numeric(levels(extracted$Sub_metering_2))[extracted$Sub_metering_2]
extracted$Sub_metering_3 <- as.numeric(levels(extracted$Sub_metering_3))[extracted$Sub_metering_3]


# Make plot
with(extracted,plot(DateTime, Sub_metering_1, type ="l", xlab = "", ylab = "Energy sub metering"))
with(extracted, lines(DateTime, Sub_metering_2, col="red"))
with(extracted, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty = c(1, 1, 1), col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Save to PNG file
dev.copy(png, file = "plot3.png")
dev.off()

