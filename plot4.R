all_data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
#change it into a date type:
all_data$Date <- as.Date(all_data$Date, "%d/%m/%Y")
#select the required dates
small_set <- subset(all_data, all_data$Date >= '2007-02-01' & all_data$Date <= '2007-02-02')
#remove the *big* data set:
rm (all_data)
#change the needed meterings to numeric:
small_set$Sub_metering_1 <- as.numeric(small_set$Sub_metering_1)
small_set$Sub_metering_2 <- as.numeric(small_set$Sub_metering_2)
small_set$Sub_metering_3 <- as.numeric(small_set$Sub_metering_3)

small_set$DateTime <- as.POSIXct(paste0(small_set$Date, as.character(small_set$Time)), format="%Y-%m-%d%H:%M:%S")

#create the file:
png("plot4.png", width = 480, height = 480)

#make sure we have 4 plots:
par(mfrow = c(2,2))
#and arrange for enough space
par(mar = c(5, 5, 5, 5))

#the first one is the global line chart:
small_set$Global_active_power <- as.numeric(small_set$Global_active_power)
#start the plot, but without dots
plot(small_set$DateTime, small_set$Global_active_power, type = "n", ylab = "Global active power (kilowatts", xlab = "")
#then make the linedrawing
lines(small_set$DateTime, small_set$Global_active_power)

#the second one is with datetime vs Voltage
#start the plot, without the dots, and set the vertical limits between 234 and 246:
plot(small_set$DateTime, small_set$Voltage, type = "n", ylab = "Voltage", xlab = "Datetime", ylim = c(234, 246))
#then draw the actual line
lines(small_set$DateTime, small_set$Voltage)

#the third one is the sub_meterings:
#start the plot, but without dots
plot(small_set$DateTime, small_set$Sub_metering_1, type = "n", ylab = "Global active power (kilowatts", xlab = "")
lines(small_set$DateTime, small_set$Sub_metering_1)
lines(small_set$DateTime, small_set$Sub_metering_2, col = "red")
lines(small_set$DateTime, small_set$Sub_metering_3, col = "blue")
#put in the legend:
legend("topright", legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), lty = c(1, 1, 1), lwd = c(2.5, 2.5, 2.5), col = c("black", "red", "blue"))

#the last one is Global_reactive_power against date-time
plot(small_set$DateTime, small_set$Global_reactive_power, type = "n", xlab = "datetime")
#then make the linedrawing:
lines(small_set$DateTime, small_set$Global_reactive_power)

#and close of the file:
dev.off ()