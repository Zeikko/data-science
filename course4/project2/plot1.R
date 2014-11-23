library(dplyr)

if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

years <- group_by(NEI, year)
data <- summarise(years, sum(Emissions))
png("plot1.png")
plot(data$year, data$'sum(Emissions)', xlab="Year", ylab="PM2.5 Emissions (tons)", main="Total Emissions from PM2.5")
abline(lm(data$'sum(Emissions)' ~ data$year))
dev.off()