corr <- function(directory, threshold = 0) {
  ## 'threshold' is a numeric vector of length 1 indicating the 
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between 
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## Note: Do not round the result.
  
  file_list <- list.files(directory, full.names = TRUE)
  all_corr <- 0
  
  for(i in 1:length(file_list)){
    data <- read.csv(file_list[i])
    
    nobs <- sum(complete.cases(data))
    if (nobs > threshold){
      correlation <- cor(data$nitrate, data$sulfate, use = "complete.obs")
      all_corr <- c(all_corr, correlation)
    }
  
  }
  all_corr[!is.na(all_corr)]
}