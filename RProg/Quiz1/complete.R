complete <- function(directory, id = 1:332) {
  file_list <- list.files(directory, full.names = TRUE)
  file_content <- data.frame()
  for (i in id) {
    ## read data
    data <- read.csv(file_list[i])
    ## complete cases logic
    file_complete <- complete.cases(data)
    ## complete data
    complete_data <- data[file_complete,]
    ## get file info
    id <- complete_data[1,4]
    nobs <- length(complete_data[,1])
    ## make data frame, bind to existing data
    add_content <- data.frame(id, nobs)
    file_content <- rbind(file_content, add_content)
  }
}
complete("specdata", 1)
complete <- function(directory, id = 1:332) {
  file_list <- list.files(directory, full.names = TRUE)
  final_content <- data.frame()
  for (i in id) {
    ## read data
    data <- read.csv(file_list[i])
    ## complete cases logic
    file_complete <- complete.cases(data)
    ## complete data
    complete_data <- data[file_complete,]
    ## get file info
    id <- complete_data[1,4]
    nobs <- length(complete_data[,1])
    ## make data frame, bind to existing data
    add_content <- data.frame(id, nobs)
    final_content <- rbind(file_content, add_content)
    final_content
  }
}
complete("specdata", 1)
complete <- function(directory, id = 1:332) {
  file_list <- list.files(directory, full.names = TRUE)
  final_content <- data.frame()
  for (i in id) {
    ## read data
    data <- read.csv(file_list[i])
    ## complete cases logic
    file_complete <- complete.cases(data)
    ## complete data
    complete_data <- data[file_complete,]
    ## get file info
    id <- complete_data[1,4]
    nobs <- length(complete_data[,1])
    ## make data frame, bind to existing data
    add_content <- data.frame(id, nobs)
    final_content <- rbind(final_content, add_content)
    final_content
  }
}
complete("specdata", 1)
complete("specdata", 1)
complete <- function(directory, id = 1:332) {
  file_list <- list.files(directory, full.names = TRUE)
  final_content <- data.frame()
  for (i in id) {
    ## read data
    data <- read.csv(file_list[i])
    ## complete cases logic
    file_complete <- complete.cases(data)
    ## complete data
    complete_data <- data[file_complete,]
    ## get file info
    file_id <- complete_data[1,4]
    nobs <- length(complete_data[,1])
    ## make data frame, bind to existing data
    add_content <- data.frame(file_id, nobs)
    final_content <- rbind(final_content, add_content)
  }
  final_content
}
complete("specdata", c(2, 4, 8, 10, 12))
git push origin master
q()