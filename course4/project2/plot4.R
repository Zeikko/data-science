library(ggplot2)
library(dplyr)

if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

coal <- SCC[grepl("Coal",SCC$EI.Sector),]

filtered = filter(NEI, SCC %in% coal$SCC)
years <- group_by(filtered, year)
data <- summarise(years, sum(Emissions))
names(data)[2] <- 'emissions'
png("plot4.png")
ggplot(data, aes(x=year, y=emissions)) + geom_point() + geom_smooth(method=lm, se=FALSE) + ggtitle("Total Emissions PM2.5 from Coal Combustion related sources") + xlab('Year') + ylab('PM2.5 Emissions (tons)')
dev.off()