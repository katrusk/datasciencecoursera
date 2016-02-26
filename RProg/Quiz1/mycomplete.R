complete <- function(directory, id = 1:332) {
  ## Return a data frame of the form:
  ## id nobs
  ## 1 117
  ## 2 1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the 
  ## number of complete cases
  
  file_list <- list.files(directory, full.names = TRUE)
  final_content <- data.frame()
  
  for(i in id){
    data <- read.csv(file_list[i])
    file_complete <- complete.cases(data)
    complete_data <- data[file_complete,]
    
    monitor_id <- complete_data[1,4]
    nobs <- length(complete_data[,1])
    
    add_content <- data.frame(monitor_id, nobs)
    final_content <- rbind(final_content, add_content)
  }
  final_content
}