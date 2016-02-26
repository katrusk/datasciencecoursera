pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## Return the mean of the pollutant across all monitors listed
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the results.
  
  file_list <- list.files(directory, full.names = TRUE)
  total_pollutant <- 0
  for(i in id){
      data <- read.csv(file_list[i])
      file_complete <- complete.cases(data)
      complete_data <- data[file_complete,]
  
      comp_pollutant <- complete_data[, pollutant]
      total_pollutant <- c(total_pollutant, comp_pollutant)
  }
  mean(total_pollutant)
  
}