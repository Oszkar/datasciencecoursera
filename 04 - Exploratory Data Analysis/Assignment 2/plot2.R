## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- NEI[which(NEI$fips == "24510"), ]
baltimore_by_year <- with(baltimore, aggregate(Emissions, by = list(year), sum))

# simple line plot
plot(baltimore_by_year, type="o", main = "Total Emission in Baltimore City", ylab = "Total Emission (tons)", xlab = "Year")

# trendline
abline(lm(baltimore_by_year$x ~ baltimore_by_year$Group.1))

# calculate decrease percentage
decrease_percent = (baltimore_by_year[1,2] - baltimore_by_year[4,2]) / baltimore_by_year[1,2] * 100

# display percent on plot
mtext(sprintf("Decrease over 9 years: %.3f %%", decrease_percent), 3)

# save as png with transparent background
dev.copy(png,filename="plot2.png");
# shut down device
dev.off()