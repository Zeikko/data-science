best <- function(state, outcome) {
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
  ranking <- do.call("order", hospitals[c(column, "Hospital.Name")])
  ## Return hospital name in that state with lowest 30-day death rate
  hospitals[ranking[1],2]
}