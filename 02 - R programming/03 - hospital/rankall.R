rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  outcomes[, 11] <- as.numeric(outcomes[, 11]) # heart attack
  outcomes[, 17] <- as.numeric(outcomes[, 17]) # heart failure
  outcomes[, 23] <- as.numeric(outcomes[, 23]) # pneumonia
  
  states = sort(unique(outcomes$State))
  t <- c()
  
  bestCase <- (num == "best") 
  worstCase <- (num == "worst")
  
  for(state in states) {
    if(outcome == "heart attack") {
      column <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
      single_state <- outcomes[outcomes[, 7]==state, ]
      ordered <- order(single_state[column], single_state$Hospital.Name, na.last=NA)
      
    } else if(outcome == "heart failure") {
      column <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
      single_state <- outcomes[outcomes[, 7]==state, ]
      ordered <- order(single_state[column], single_state$Hospital.Name, na.last=NA)
      
    } else if(outcome == "pneumonia") {
      column <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
      single_state <- outcomes[outcomes[, 7]==state, ]
      ordered <- order(single_state[column], single_state$Hospital.Name, na.last=FALSE)
    } else {
      stop("invalid outcome")
    }
    
    if(bestCase) {
      num <- 1
    }
    if(worstCase) {
      num <- length(ordered)
    }
    
    t <- c(t, as.character(single_state$Hospital.Name[ordered[num]]))
  }
  
  result <- data.frame(t, states)
  colnames(result) <- c('hospital', 'state')
  
  return(result)
}