# Introduction

This code book is a guide to the data, variables and transformations used to complete the final project for the Coursera Getting and Cleaning Data week-four project.  A provided data set was modified and organized to meet the following objectives of the assignment:

1) Merge the training-set and test-set data, label and subject files. 

2) Gather the mean and standard deviation data for each measurement to a table.

3) Change the activity labels to descriptive names.

4) Modify the variable labels to more descriptive names.

5) Using the data from objectives 1-4, create a new data set displaying the mean of each variable grouped by activity and subject.

# Data

The data provided include measurements acquired using a smart phone device to monitor the six activities (sitting, standing, laying, walking, walking upstairs and walking downstairs) performed by thirty participating subjects.  

Website description of research project: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Activity data set used in this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

UCI HAR Dataset/activity_labels.txt
> key of activities and designated activity numbers

UCI HAR Dataset/features.txt
> list of variables measured or calculated for each activity (561 total)

UCI HAR Dataset/test/X_test.txt
> test data set containing variable measurements (2947 rows, 561 columns)

UCI HAR Dataset/test/y_test.txt
> test data designated activity numbers (1-6, 2947 rows total)

UCI HAR Dataset/test/subject_test.txt
> test data subject identification numbers (1-30, 2947 rows total) 

UCI HAR Dataset/train/X_train.txt
> train data set containing variable measurements (7352 rows, 561 columns)

UCI HAR Dataset/train/y_train.txt
> test data designated activity numbers (1-6, 7352 rows total)

UCI HAR Dataset/train/subject_train.txt
> test data subject identification numbers (1-30, 7352 rows total)

# Variables

For a complete description of experimental variables and collection or calculation methods, see: UCI HAR Dataset/features_info.txt

Variables used in this assignment were selected from the original pool of 561 by removing duplicate variable names and using keyword searches for 'mean' and 'std' (ignoring letter case), resulting in a data set with the measurements for all mean and standard deviation variables.  (86 variables total)  

# Transformations

Objective 1: Merge the training-set and test-set data, activity and subject files.
1.  Mutated training/test data, activity and subject tables to add 'samp' column with ascending ints (1-2947 for test and 2948-10299 for train).
2.  Rename activity and subject column V1's to "activity" and "subject"
3.  Merge data, activity and subject tables by 'samp'.
4.  Merge complete test and train tables by all.

Objective 2: Gather the mean and standard deviation data for each measurement to a table.
1.  Apply list of descriptive variable names to test/train table.
2.  Remove special characters from names and remove duplicate names in preparation for selecting 'mean' and 'std' specific columns.
3.  Grep and sort indices for 'mean' and 'std' variable names.
4.  Select the columns indicated by the resulting list of indices and assign to new table.

Objective 3: Change the activity labels to descriptive names.
1.  Use mutate and gsub to rename all activity numbers in the "activity" column with descriptive activity names provided in activity_labels.txt.

Objective 4: Modify the variable labels to more descriptive names.
*Note that adjustments to variable labels were first made in objective 2, item 2 to remove special characters.  This modification also enhances readability, which increases descriptive value of variable names.
1.  Remove uppercase letters and duplicate words in variable names.  

Objective 5: Using the data from objectives 1-4, create a new data set displaying the mean of each variable grouped by activity and subject.
1.  Use group_by to group the table from objective 4 by activity type and subject.
2.  Use summarize_each to find the average measurement for all values corresponding to each activity and participating subject.