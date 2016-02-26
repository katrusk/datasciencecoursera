rankhospital <- function(state, outcome, num = "best") {
  # read outcome
  data <- read.csv(file="outcome-of-care-measures.csv", colClasses = 'character')
  
  if(!any(state == data$State)) {
    stop('invalid state')
  }
  
  if(outcome == 'heart attack') {
    i <- 11
  }
  else if(outcome == 'heart failure') {
    i <- 17
  }
  else if(outcome == 'pneumonia') {
    i <- 23
  }
  else {
    stop('invalid outcome')
  }
  
  data.state <- data[data$State == state, ]
  data.state[, i] <- as.numeric(x=data.state[, i])
  
  
  data.state <- data.state[complete.cases(data.state), ]
  
  # print(data.state[, c(2, i)])
  
  if(num == "best") {
    num = 1
  }
  else if(num == "worst") {
    num = nrow(data.state)
  }
  else if(is.numeric(x=num)) {
    # print(num)
    if(num<1 || num > nrow(data.state)) {
      return(NA)
    }
  }
  else {
    stop('invalid num')
  }
  
  # print(sort(data.state[, i]))
  
  data.state <- data.state[order(data.state[,i], data.state$Hospital.Name), ]
  
  return.names <- data.state[num, ]$Hospital.Name
  
  # print(return.names)
  
  return.names[1]
}