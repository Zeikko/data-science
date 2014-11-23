library(ggplot2)
library(dplyr)

if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

motor <- SCC[grepl("Vehicle",SCC$EI.Sector),]

filtered = filter(NEI, SCC %in% motor$SCC)
filtered = filter(NEI, fips == "24510")
years <- group_by(filtered, year)
data <- summarise(years, sum(Emissions))
names(data)[2] <- 'emissions'
png("plot5.png")
ggplot(data, aes(x=year, y=emissions)) + geom_point() + geom_smooth(method=lm, se=FALSE) + ggtitle("Total Emissions PM2.5 from Motor Vehicles in Baltimore City") + xlab('Year') + ylab('PM2.5 Emissions (tons)')
dev.off()