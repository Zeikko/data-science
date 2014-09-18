complete <- function(directory, id = 1:332) {
  for(i in id) { 
    filename <- i
    while(nchar(filename) < 3) {
      filename <- paste('0', filename, sep="")
    }
    path <- paste(directory, '/', filename, '.csv', sep="")
    data <- read.csv(path)
    cases = complete.cases(data)
    if(exists('result')) {
      result <- rbind(result, data.frame(id=i, nobs=sum(cases)))
    } else {
      result <- data.frame(id=i, nobs=sum(cases))
    }
  }
  result
}