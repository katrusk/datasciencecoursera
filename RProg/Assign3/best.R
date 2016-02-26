## R Programming, Week 4.. Jan 31 2015

## PA3 Part I
## view data
##outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

## create histogram of 30-day mortality for heart attack
##outcome2 <- as.numeric(outcome[, 11])
##hist(outcome2)

## PA3 Part II
## find the best hospital in a state

## takes two arguments, 2-character abbr state name and outcome name
## reads the outcome-of-care-measures.csv
## returns a character vector with the name of the hospital
## outcome names can be 'heart attack', 'heart failure', or 'pneumonia'
## hospitals without data are excluded

best <- function(state, outcome) {
  ## read the outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv", 
                           colClasses = "character")
  
  ## check that state and outcome are valid
  if(!state_valid(state)) {
    stop('invalid state')
  }
  if(!outcome_valid(outcome)) {
    stop('invalid outcome')
  }
  
  ## return name of hospital with lowest 30-day death rate
  ## Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
  ## Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
  ## Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack
  ## State, Hospital.Name
  find_records <- outcome_data[, "State"] == state
  records <- outcome_data[find_records,]
  
  rate_col <- find_rate_col(outcome) 
  find_rate <- as.numeric(records[, rate_col])
  lowest_rate <- min(find_rate, na.rm = TRUE)
  if(!length(lowest_rate) == 1) {
    rate_msg <- "multiple rates returned"
    rate_msg
    
    find_rate_rec <- as.numeric(records[, rate_col]) == lowest_rate
    record_indexes <- all('TRUE' %in% find_rate_rec)
    rate_records <- records[record_indexes,]
    hosp_names <- NULL
    for (rec in rate_records) {
      hosp_names <- c(hosp_names, rec$Hospital.Name)
    }
    order_list <- order(hosp_names)
    hosp_names[order_list[1]]
  } else {
    find_rate_rec <- as.numeric(records[, rate_col]) == lowest_rate
    record_index <- match('TRUE', find_rate_rec)
    final_record <- records[record_index,]
    final_record$Hospital.Name
  }
  
  
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

find_rate_col <- function(outcome) {
  if (outcome == "heart attack") {
    rate_col <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" 
  }
  else if (outcome == "heart failure") {
    rate_col <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  }
  else { rate_col <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" }
  rate_col
}

