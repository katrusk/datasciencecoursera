## R Programming, Week 4.. Jan 31 2015

## PA3 Part III
## view data
##outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

## arguments: 2-char abbr state, outcome, desired rank as num
## returns name of hospital with specified rank and location
## num can be 'best', 'worst', or integer
## a rank higher than the number of hospitals for a state returns NA
## hospitals with missing information are excluded
## ties are handled by ordering alphabetically and choosing the first
## arguments must be validated

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if(!state_valid(state)) {
    stop('invalid state')
  }
  if(!outcome_valid(outcome)) {
    stop('invalid outcome')
  }
  
  ## Return hospital name in that state with the given rank
  ## get list of rows containing state
  state_records <- data[data$State == state,]
  
  ## 30-day death rate
  ## get column name for specified outcome
  column <- column_name(outcome)
  
  state_records[, column] <- as.numeric(state_records[, column])
  state_records <- state_records[complete.cases(state_records), ]
  
  state_records <- state_records[order(state_records[, column], 
                                       state_records$Hospital.Name), ]
  
  ## set num to integer if best or worst
  if (num == 'best') {
    num <- 1
  }
  if (num == 'worst') {
    num <- nrow(state_records)
  }
  if (!is.numeric(num)) {
    stop("invalid rank number") 
  }
  
  state_records[num, ]$Hospital.Name
}

state_valid <- function(state_abbr) {
  state_list <- state.abb
  msg <- FALSE
  for (i in state_list) {
    if (i == state_abbr) {
      msg <- TRUE 
    } 
  }
  msg
}
outcome_valid <- function(outcome) {
  outcome == "heart attack" || outcome == "heart failure" ||
    outcome == "pneumonia"
}

column_name <- function(outcome) {
  if (outcome == "heart attack") {
    col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" 
  }
  else if (outcome == "heart failure") {
    col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  }
  else { col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" }
  col_name
}