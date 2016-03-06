## getting-and-cleaning-data-course-project
## March 1, 2016
## K.J.Rusniak/katrusk

# This script takes an activity data set provided in mutiple sections, creates 
# one complete and readable data set containing all experimental observations for 
# mean and stdev variables (Objective 1 - Objective 4), and creates a final data set 
# containing the ave value of all measurements by activity and subject (Objective 5).

run_analysis <- function() {
  ## Objective 1
  ## merge training and test sets

  # get test data, get activity and subject labels
  test <- tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt"))
  # dim(test); [1] 2947 561
  test_label <- tbl_df(read.table("./UCI HAR Dataset/test/y_test.txt"))
  # dim(test_label); [1] 2947 1
  test_subject <- tbl_df(read.table("./UCI HAR Dataset/test/subject_test.txt"))

  # add 'samp' row count column to each test table and merge
  test_prep <- mutate(test, samp = c(1:2947)) # dim: 2947 562
  test_label_prep <- mutate(test_label, samp = c(1:2947)) # dim: 2947 2
  names(test_label_prep)[1] <- "activity"
  test_subject_prep <- mutate(test_subject, samp = c(1:2947)) # dim: 2947 2
  names(test_subject_prep)[1] <- "subject"

  test_merge <- merge(test_label_prep, test_prep, by = "samp") # dim: 2947 563
  test_merge2 <- merge(test_subject_prep, test_merge, by = "samp") # dim: 2947 564

  # get train data, get activity and subject labels
  train <- tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt"))
  # dim(train); [1] 7352 561
  train_label <- tbl_df(read.table("./UCI HAR Dataset/train/y_train.txt"))
  # dim(train_label); [1] 7352 1
  train_subject <- tbl_df(read.table("./UCI HAR Dataset/train/subject_train.txt"))
  # dim(train_subject); [1] 7352 1

  # add 'samp' row count column to each train table and merge
  train_prep <- mutate(train, samp = c(2948:10299)) # dim: 7352 562
  train_label_prep <- mutate(train_label, samp = c(2948:10299)) # dim: 7352 2
  names(train_label_prep)[1] <- "activity"
  train_subject_prep <- mutate(train_subject, samp = c(2948:10299)) # dim 7352 2
  names(train_subject_prep)[1] <- "subject"

  train_merge <- merge(train_label_prep, train_prep, by = "samp") # dim: 7352 563
  train_merge2 <- merge(train_subject_prep, train_merge, by = "samp") # dim: 7352 564

  # merge test and train tables
  test_train <- merge(test_merge2, train_merge2, all = TRUE)
  # dim(test_train); [1] 10299 564

  ## Objective 2
  ## extract mean and stdev for each measurement

  # get variable/column labels and apply to data table
  label_df <- read.table("./UCI HAR Dataset/features.txt")
  label <- as.character(label_df[,2])
  names(test_train)[4:564] <- label[1:561]

  # remove special characters and column name doubles 
  names(test_train) <- gsub("[-(),]", "", names(test_train))
  tt_data <- test_train[ , unique(names(test_train))] # dim: 10299 480

  # locate and sort indices with 'mean' and 'std' key words
  mean_std_index <- c(grep("mean", names(tt_data), ignore.case = TRUE), 
                      grep("std", names(tt_data), ignore.case = TRUE)) %>% sort()

  # select identified indices and assign to new table
  tt_data2 <- select(tt_data, 1:3, mean_std_index) # dim: 10299 89

  ## Objective 3
  ## use descriptive activity names to name activities in data set

  # substitute activity numbers with corresponding action words
  # 1 WALK 2 WALK_UP 3 WALK_DOWN 4 SIT 5 STAND 6 LAY
  tt_data2 <- mutate(tt_data2, activity = gsub("[1]", "walk", tt_data2[,"activity"]))
  tt_data2 <- mutate(tt_data2, activity = gsub("[2]", "walk_up", tt_data2[,"activity"]))
  tt_data2 <- mutate(tt_data2, activity = gsub("[3]", "walk_down", tt_data2[,"activity"]))
  tt_data2 <- mutate(tt_data2, activity = gsub("[4]", "sit", tt_data2[,"activity"]))
  tt_data2 <- mutate(tt_data2, activity = gsub("[5]", "stand", tt_data2[,"activity"]))
  tt_data2 <- mutate(tt_data2, activity = gsub("[6]", "lay", tt_data2[,"activity"]))

  ## Objective 4
  ## label data set with descriptive variable names

  # remove upper case letters, remove repeat words to improve readability
  names(tt_data2) <- tolower(names(tt_data2))
  names(tt_data2) <- sub("bodybody", "body", names(tt_data2))

  ## Objective 5
  ## create second tidy data set w/ ave of each variable per activity and subject

  # summarize data set with mean of variables grouped by activity and subject
  by_activity_subject <- group_by(tt_data2, activity, subject) # 10299 89
  by_actsub_ave <- summarize_each(by_activity_subject, funs(mean), 4:89) %>% print()
  # dim: 180 88

  # write final tidy data set to home directory
  write.table(by_actsub_ave, file = "./mean_measures_by_activity_subject.txt", 
              row.name = FALSE)

  # grouped only by activity
  # by_activity <- group_by(tt_data2, activity) # dim: 10299 89
  # by_activity_ave <- summarize_each(by_activity, funs(mean), 4:89) # dim: 6 87

  # grouped only by subject
  # by_subject <- group_by(tt_data2, subject)
  # by_subject_ave <- summarize_each(by_subject, funs(mean), 4:89) # dim: 30 87
}