plot3 <- function() {
  ## save as png with transparent background
  png(file="plot3.png", width=480, height=480, bg="transparent")
  
  ## read the relevant data set
  data <- read.csv("household_power_consumption_2007_01_01_02_subset.txt", header = TRUE)
  data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
  
  ## create timestamp from date + time
  data$DateTime <- paste(data$Date, data$Time)
  data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
  
  ## create plot and add two more lines
  plot(data$DateTime, data$Sub_metering_1, type ="l", xlab="", ylab="Energy sub metering", cex.lab=0.8, cex.axis=0.8)
  points(data$DateTime, data$Sub_metering_2, type ="l", col="red")
  points(data$DateTime, data$Sub_metering_3, type ="l", col="blue")
  legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
  
  ## shut down device
  dev.off()
}