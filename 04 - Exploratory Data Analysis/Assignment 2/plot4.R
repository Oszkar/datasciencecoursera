## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get SCC info for coal (some names have capital C!)
coal_id <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
coal_scc_data <- SCC[coal_id, ]

# filter NEI based on the coal SCC
coal_data <- NEI[NEI$SCC %in% as.character(coal_scc_data$SCC), ]

# this time, we aggregate by both year and type
coal_by_year <- with(coal_data, aggregate(Emissions, by = list(year), sum))

# simple line plot
plot(coal_by_year, type="o", main = "Coal Related Emission in the US", ylab = "Emission (tons)", xlab = "Year")

# trendline
abline(lm(coal_by_year$x ~ coal_by_year$Group.1))

# calculate decrease percentage
decrease_percent = (coal_by_year[1,2] - coal_by_year[4,2]) / coal_by_year[1,2] * 100

# display percent on plot
mtext(sprintf("Decrease over 9 years: %.3f %%", decrease_percent), 3)

# save as png
dev.copy(png,filename="plot4.png");
# shut down device
dev.off()
