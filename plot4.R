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

# Convert Global_active_power, Voltage, Global_reactive_power from factor to number
extracted$Global_active_power <- as.numeric(levels(extracted$Global_active_power))[extracted$Global_active_power]
extracted$Voltage <- as.numeric(levels(extracted$Voltage))[extracted$Voltage]
extracted$Global_reactive_power <- as.numeric(levels(extracted$Global_reactive_power))[extracted$Global_reactive_power]


# Make plot
par(mfrow = c(2, 2))

# topleft
with(extracted,plot(DateTime, Global_active_power, type ="l", xlab = "", ylab = "Global Active Power"))
# topright
with(extracted,plot(DateTime, Voltage, type ="l", xlab = "datetime"))

# bottomleft
with(extracted,plot(DateTime, Sub_metering_1, type ="l", xlab = "", ylab = "Energy sub metering"))
with(extracted, lines(DateTime, Sub_metering_2, col="red"))
with(extracted, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty = c(1, 1, 1), bty = "n", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# bottomright
with(extracted,plot(DateTime, Global_reactive_power, type ="l", xlab = "datetime"))

# Save to PNG file
dev.copy(png, file = "plot4.png")
dev.off()


