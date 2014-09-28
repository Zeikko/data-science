rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  hospitals <- read.csv("/home/zeikko/Projects/data-science/course2/assignment3/data/outcome-of-care-measures.csv", colClasses = "character")  
  ## Check that state and outcome are valid
  hospitals <- subset(hospitals, State == state)
  if(nrow(hospitals) == 0) {
    stop('Invalid State')
  }
  
  if(outcome == 'heart attack') {
    column = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  } else if (outcome == 'heart failure') {
    column = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  } else if (outcome == 'pneumonia') {
    column = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  } else {
    stop('Invalid outcome')
  }
  
  hospitals[,column] <- as.numeric(hospitals[,column])
  hospitals <- hospitals[complete.cases(hospitals[,column]),]
  ranking <- do.call("order", hospitals[c(column, "Hospital.Name")])
  ## Return hospital name in that state with the given rank 30-day death rate
  if(num == 'best') {
    num <- 1
  }
  
  if(num == 'worst') {
    tail(hospitals[ranking,c(2)], n=1)
  } else {
    hospitals[ranking[num],c(2)]
  }
}

