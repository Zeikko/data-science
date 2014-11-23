library(ggplot2)
library(dplyr)

fipsToName <- function(fips) {
  city <- ""
  if(fips == "24510") {
    city <- "Baltimore City"
  } else if(fips == "06037") {
    city <- "Los Angeles County"
  }
  city
}

if(!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

motor <- SCC[grepl("Vehicle",SCC$EI.Sector),]

filtered = filter(NEI, SCC %in% motor$SCC)
cities = c("24510", "06037")
filtered = filter(NEI, fips %in% cities)
filtered <- mutate(filtered, city=sapply(fips, fipsToName))
years <- group_by(filtered, year, city)
data <- summarise(years, sum(Emissions))
names(data)[3] <- 'emissions'
png("plot6.png")
ggplot(data, aes(x=year, y=emissions)) + geom_point() + facet_grid(city ~ .) + geom_smooth(method=lm, se=FALSE) + ggtitle("Total Emissions PM2.5 from Motor Vehicles") + xlab('Year') + ylab('PM2.5 Emissions (tons)')
dev.off()

