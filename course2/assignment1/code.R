pollutantmean <- function(directory, pollutant, id = 1:332) {
  for(i in 1:length(id)) { 
    filename <- id[i]
    while(nchar(filename) < 3) {
      filename <- paste('0', filename, sep="")
    }
    print(filename)
    path <- paste(directory, filename, '.csv', sep="")
    if(exists('data')) {
      data <- rbind(data, read.csv(path))
    } else {
      data <- read.csv(path)
    }
  }
  mean(data[,pollutant], na.rm = TRUE)
}