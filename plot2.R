all_data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
#change it into a date type:
all_data$Date <- as.Date(all_data$Date, "%d/%m/%Y")
#select the required dates
small_set <- subset(all_data, all_data$Date >= '2007-02-01' & all_data$Date <= '2007-02-02')
#remove the *big* data set:
rm (all_data)
#change the active_powe to numeric:
small_set$Global_active_power <- as.numeric(small_set$Global_active_power)
small_set$DateTime <- as.POSIXct(paste0(small_set$Date, as.character(small_set$Time)), format="%Y-%m-%d%H:%M:%S")

#create the file:
png("plot2.png", width = 480, height = 480)

#start the plot, but without dots
plot(small_set$DateTime, small_set$Global_active_power, type = "n", ylab = "Global active power (kilowatts)", xlab = "")
#then make the linedrawing
lines(small_set$DateTime, small_set$Global_active_power)

#and close of the file:
dev.off ()