library(ggplot2)

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
la_motor_data <- motor_data[which(motor_data$fips == "06037"), ]

# this time, we aggregate by both year and type
baltimore_motor_by_year <- with(baltimore_motor_data, aggregate(Emissions, by = list(year), sum))
la_motor_by_year <- with(la_motor_data, aggregate(Emissions, by = list(year), sum))

# merge the 2 data set
cities_data <- rbind(baltimore_motor_by_year, la_motor_by_year)
# add the city names and column names
cities_data <- cbind(cities_data, c("Baltimore", "Baltimore", "Baltimore", "Baltimore", "Lost Angeles", "Lost Angeles", "Lost Angeles", "Lost Angeles"))
names(cities_data) <- c("Year", "Emission", "County")

# draw plot (4 lines on a signle plot diagram)
p <- qplot(Year, Emission, 
           data = cities_data, 
           group = County, 
           color = County,
           geom = c("line"),
           main = "Total Emissions in Baltimore City vs Los Angeles Conty",
           ylab = "Total Emissions (tons)",
           xlab = "Year")

# calculate decrease percentage
decrease_percent = (baltimore_motor_by_year[1,2] - baltimore_motor_by_year[4,2]) / baltimore_motor_by_year[1,2] * 100
decrease_percent_la = (la_motor_by_year[1,2] - la_motor_by_year[4,2]) / la_motor_by_year[1,2] * 100

# display percent on plot
p + annotate("text", x = 2003.5, y = 700,
             label = sprintf("Decrease over 9 years: Baltimore City %.3f%%, Los Angeles County %.3f%%", decrease_percent, decrease_percent_la),
             size = 4)

# save as png
# save as png
ggsave(filename="plot6.png", dpi=100)
