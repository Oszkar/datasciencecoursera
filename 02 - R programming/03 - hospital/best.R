best <- function(state, outcome) {
  ## Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  outcomes[, 11] <- as.numeric(outcomes[, 11]) # heart attack
  outcomes[, 17] <- as.numeric(outcomes[, 17]) # heart failure
  outcomes[, 23] <- as.numeric(outcomes[, 23]) # pneumonia
  
  ## Check that state and outcome are valid
  if(!state %in% unique(outcomes$State)) {
    stop("invalid state")
  }
  
  if(outcome == "heart attack") {
    single_state <- outcomes[outcomes[, 7]==state, ]
    min <- min(single_state[, 11], na.rm = TRUE)
    min_index <- which(single_state[, 11] == min)
    hosp_name <- single_state[min_index, 2]
    return(hosp_name)
    
  } else if(outcome == "heart failure") {
    single_state <- outcomes[outcomes[, 7]==state, ]
    min <- min(single_state[, 17], na.rm = TRUE)
    min_index <- which(single_state[, 17] == min)
    hosp_name <- single_state[min_index, 2]
    return(hosp_name)
    
  } else if(outcome == "pneumonia") {
    single_state <- outcomes[outcomes[, 7]==state, ]
    min <- min(single_state[, 23], na.rm = TRUE)
    min_index <- which(single_state[, 23] == min)
    hosp_name <- single_state[min_index, 2]
    return(hosp_name)
  } else {
    stop("invalid outcome")
  }
      
  ## Return hospital name in that state with lowest 30-day death
  ## rate
}