library(ggplot2)
library(dplyr)

if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

filtered = filter(NEI, fips == "24510")
years <- group_by(filtered, year, type)
data <- summarise(years, sum(Emissions))
names(data)[3] <- 'emissions'
png("plot3.png")
ggplot(data, aes(x=year, y=emissions)) + geom_point() + facet_grid(type ~ .) + geom_smooth(method=lm, se=FALSE) + ggtitle("Total Emissions from PM2.5 by type") + xlab('Year') + ylab('PM2.5 Emissions (tons)')
dev.off()