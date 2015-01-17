## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# aggregate data (this can be few seconds, too)
data_by_year <- with(NEI, aggregate(Emissions, by = list(year), sum))

# simple line plot
plot(data_by_year, type="o", main = "Total Emission in the US", ylab = "Total Emission (tons)", xlab = "Year")

# trendline
abline(lm(data_by_year$x ~ data_by_year$Group.1))

# calculate decrease percentage
decrease_percent = (data_by_year[1,2] - data_by_year[4,2]) / data_by_year[1,2] * 100

# display percent on plot
mtext(sprintf("Decrease over 9 years: %.3f %%", decrease_percent), 3)

# save as png
dev.copy(png,filename="plot1.png");
# shut down device
dev.off()