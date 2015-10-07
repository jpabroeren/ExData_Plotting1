all_data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
#change it into a date type:
all_data$Date <- as.Date(all_data$Date, "%d/%m/%Y")
#select the required dates
small_set <- subset(all_data, all_data$Date >= '2007-02-01' & all_data$Date <= '2007-02-02')
#remove the *big* data set:
rm (all_data)
#change the active_power to numeric:
small_set$Global_active_power <- as.numeric(small_set$Global_active_power)

#create the file:
png("plot1.png", width = 480, height = 480)
#create the histogram:
hist (small_set$Global_active_power, col = 'red', main = "Global active power", xlab = "Global active power (kilowatts)", breaks = 12, ylim = c(0, 1200))
#and close of the file:
dev.off ()