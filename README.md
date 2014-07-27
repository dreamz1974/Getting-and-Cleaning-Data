#Getting-and-Cleaning-Data - Project
-------------------------------------
As per the course assignment, We should create one R script called run_analysis.R that does the following.
• Merges the training and the test sets to create one data set.
• Extracts only the measurements on the mean and standard deviation for each measurement.
• Uses descriptive activity names to name the activities in the data set
• Appropriately labels the data set with descriptive activity names.
• Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data Set
-----------
 Source dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
 
##Assumptions & Notes
----------------------
1. Requires the ```dplyr``` & ```reshape2``` packages to be installed.
2. All Column names containing `...mean()` and `...std()` in them have been extracted.
3. The `CodeBook.md` describes the variables, the data, and the work that has been performed to clean up the data.
  
## Steps for Execution of this course project
========================================
1. Download the data source and put into a folder on your local drive. You'll have a ```UCI HAR Dataset``` folder.
2. Put ```run_analysis.R``` in the parent folder of ```UCI HAR Dataset```, then set it as your working directory using ```setwd()``` function in RStudio.
3. Run ```source("run_analysis.R")```, which will generate new files ```TidyData.txt``` and ```TidyAverageData.txt```in your working directory.