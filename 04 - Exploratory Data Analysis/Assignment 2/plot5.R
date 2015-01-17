## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get SCC info for motor (some names have capital letters)
motor_id <- grep("motor|vehicle", SCC$Short.Name, ignore.case = TRUE)
motor_scc_data <- SCC[motor_id, ]

# filter NEI based on the motor SCC
motor_data <- NEI[NEI$SCC %in% as.character(motor_scc_data$SCC), ]

# filter down to Baltimore
baltimore_motor_data <- motor_data[which(motor_data$fips == "24510"), ]

# this time, we aggregate by both year and type
baltimore_motor_by_year <- with(baltimore_motor_data, aggregate(Emissions, by = list(year), sum))

# simple line plot
plot(baltimore_motor_by_year, type="o", main = "Motor Vehicle Related Emission in Baltimore City", ylab = "Emission (tons)", xlab = "Year")

# trendline
abline(lm(baltimore_motor_by_year$x ~ baltimore_motor_by_year$Group.1))

# calculate decrease percentage
decrease_percent = (baltimore_motor_by_year[1,2] - baltimore_motor_by_year[4,2]) / baltimore_motor_by_year[1,2] * 100

# display percent on plot
mtext(sprintf("Decrease over 9 years: %.3f %%", decrease_percent), 3)

# save as png
dev.copy(png,filename="plot5.png");
# shut down device
dev.off()
