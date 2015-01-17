plot4 <- function() {
  ## save as png with transparent background
  png(file="plot4.png", width=480, height=480, bg="transparent")
  
  ## read the relevant data set
  data <- read.csv("household_power_consumption_2007_01_01_02_subset.txt", header = TRUE)
  data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
  
  ## create timestamp from date + time
  data$DateTime <- paste(data$Date, data$Time)
  data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
  
  ## create plots
  ## 2x2 plots
  par(mfrow = c(2, 2))
  
  # plot 1 (top left)
  plot(data$DateTime, data$Global_active_power, type= "l", ylab="Global Active Power", xlab="")
  
  # plot 2 (top right)
  plot(data$DateTime, data$Voltage, type ="l", ylab="Voltage", xlab="datetime")
  
  # plot 3 (bottom left)
  plot(data$DateTime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="", col="black")
  points(data$DateTime, data$Sub_metering_2, type = "l", col="red")
  points(data$DateTime, data$Sub_metering_3, type = "l", col="blue")
  legend("topright", lty=1, col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  # plot 4
  plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", ylim=c(0, 0.5))
  
  ## shut down device
  dev.off()
}