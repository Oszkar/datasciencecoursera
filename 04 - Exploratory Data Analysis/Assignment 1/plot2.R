plot2 <- function() {
  ## save as png with transparent background
  png(file="plot2.png", width=480, height=480, bg="transparent")
  
  ## read the relevant data set
  data <- read.csv("household_power_consumption_2007_01_01_02_subset.txt", header = TRUE)
  data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
  
  ## create timestamp from date + time
  data$DateTime <- paste(data$Date, data$Time)
  data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
  
  ## create plot
  plot(x=data$DateTime, y=data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  ## shut down device
  dev.off()
}