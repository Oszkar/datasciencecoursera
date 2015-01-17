library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- NEI[which(NEI$fips == "24510"), ]
# this time, we aggregate by both year and type
baltimore_by_year_and_type <- with(baltimore, aggregate(Emissions, by = list(year, type), sum))

# draw plot (4 lines on a signle plot diagram)
p <- qplot(Group.1, x, 
          data = baltimore_by_year_and_type, 
          group = Group.2, 
          color = Group.2,
          geom = c("line"),
          main = "Total Emissions in Baltimore City by Pollutant Type",
          ylab = "Total Emissions (tons)",
          xlab = "Year")

decrease_percent_nonroad = (baltimore_by_year_and_type[1,3] - baltimore_by_year_and_type[4,3]) / baltimore_by_year_and_type[1,3] * 100
decrease_percent_nonpoint = (baltimore_by_year_and_type[5,3] - baltimore_by_year_and_type[8,3]) / baltimore_by_year_and_type[5,3] * 100
decrease_percent_onroad = (baltimore_by_year_and_type[9,3] - baltimore_by_year_and_type[12,3]) / baltimore_by_year_and_type[9,3] * 100
decrease_percent_point = (baltimore_by_year_and_type[13,3] - baltimore_by_year_and_type[16,3]) / baltimore_by_year_and_type[13,3] * 100

p + annotate("text", x = 2004, y = 2000, 
             label = sprintf("Change over 9 years: nonroad %.3f%%, nonpoint %.3f%%,\nonroad %.3f%%, point %.3f%%", -decrease_percent_nonroad, -decrease_percent_nonpoint, -decrease_percent_onroad, -decrease_percent_point),
             size = 4)

# save as png
ggsave(filename="plot3.png", dpi=100)