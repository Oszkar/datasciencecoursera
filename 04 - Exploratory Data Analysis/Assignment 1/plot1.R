plot1 <- function() {
  ## save as png with transparent background
  png(file="plot1.png", width=480, height=480, bg="transparent")
  
  ## read the relevant data set
  data <- read.csv("household_power_consumption_2007_01_01_02_subset.txt", header = TRUE)
  data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
  
  ## create histogram
  ## cex are for smaller than default letters
  hist(data$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)", breaks=13)
  
  ## shut down device
  dev.off()
}