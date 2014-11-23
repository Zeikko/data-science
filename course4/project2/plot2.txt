library(dplyr)

if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

filtered = filter(NEI, fips == "24510")
years <- group_by(filtered, year)
data <- summarise(years, sum(Emissions))
png("plot2.png")
plot(data$year, data$'sum(Emissions)', xlab="Year", ylab="PM2.5 Emissions (tons)", main="Total Emissions from PM2.5 in Baltimore City")
abline(lm(data$'sum(Emissions)' ~ data$year))
dev.off()