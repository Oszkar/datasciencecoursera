rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  outcomes[, 11] <- as.numeric(outcomes[, 11]) # heart attack
  outcomes[, 17] <- as.numeric(outcomes[, 17]) # heart failure
  outcomes[, 23] <- as.numeric(outcomes[, 23]) # pneumonia
  
  ## Check that state and outcome are valid
  if(!state %in% unique(outcomes$State)) {
    stop("invalid state")
  }
  
  if(num == "best") {
    num <- 1
  }

  if(outcome == "heart attack") {
    column <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    single_state <- outcomes[outcomes[, 7]==state, ]
    ordered <- order(single_state[column], single_state$Hospital.Name, na.last=NA)
    if(num == "worst") {
      num <- length(ordered)
    }
    return(as.character(single_state$Hospital.Name[ordered[num]]))
    
  } else if(outcome == "heart failure") {
    column <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    single_state <- outcomes[outcomes[, 7]==state, ]
    ordered <- order(single_state[column], single_state$Hospital.Name, na.last=NA)
    if(num == "worst") {
      num <- length(ordered)
    }
    return(as.character(single_state$Hospital.Name[ordered[num]]))
    
  } else if(outcome == "pneumonia") {
    column <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    single_state <- outcomes[outcomes[, 7]==state, ]
    ordered <- order(single_state[column], single_state$Hospital.Name, na.last=NA)
    if(num == "worst") {
      num <- length(ordered)
    }
    return(as.character(single_state$Hospital.Name[ordered[num]]))
  } else {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
}