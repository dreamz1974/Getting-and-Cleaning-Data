# run_analysis.R - merges training and test data from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# Then creates a tidy data set with average values by activity and subject

# Load libraries
library(dplyr)
library(reshape2)

## Load and Merge the training and the test sets to create one data set.

## Data Directories
RootDir  <- "./UCI HAR Dataset/" 
TestDir  <- "./UCI HAR Dataset/test/"
TrainDir <- "./UCI HAR Dataset/train/" 

## Load Features and Activities data 

message("loading features.txt")
Features <- read.table(paste0(RootDir, "features.txt"), header=FALSE, stringsAsFactors=FALSE)

message("loading activity_labels.txt")
Activities <- read.table(paste0(RootDir, "activity_labels.txt"), header=FALSE, stringsAsFactors=FALSE)

message("Features and Activities Data Loaded.")

## Load Test Data
message("loading test Data")
TestSubData <- read.table(paste0(TestDir, "subject_test.txt"), header=FALSE)
TestXData   <- read.table(paste0(TestDir, "X_test.txt"), header=FALSE)
TestYData   <- read.table(paste0(TestDir, "y_test.txt"), header=FALSE)
##Adding Activities names to TestYData - Intermediary Data Set
IntTestYData <- data.frame(Activity = factor(TestYData$V1, labels = Activities$V2)) 
TestData <- cbind(IntTestYData, TestSubData, TestXData)
message("Test Data Loaded.")

## Load Train Data
message("loading Train Data")
TrainSubData  <- read.table(paste0(TrainDir, "subject_train.txt"), header=FALSE)
TrainXData    <- read.table(paste0(TrainDir, "X_train.txt"), header=FALSE)
TrainYData    <- read.table(paste0(TrainDir, "y_train.txt"), header=FALSE)
##Adding Activities names to TrainYData - - Intermediary Data Set
IntTrainYData <- data.frame(Activity = factor(TrainYData$V1, labels = Activities$V2)) 
TrainData     <- cbind(IntTrainYData, TrainSubData, TrainXData)
message("Train Data Loaded.")

##Create Tidy Data Extracting only the measurements on the mean and standard deviation
## Also label data set with variable names
message("Creating Tidy Data with mean and standard deviation")
TestTrainData <- rbind(TestData, TrainData)
names(TestTrainData) <- c("Activity", "Subject", Features[,2])
select <- Features$V2[grep("mean\\(\\)|std\\(\\)", Features$V2)]
TidyData <- TestTrainData[c("Activity", "Subject", select)]
message("Creation of Tidy Data completed.")

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
message("Creating Tidy Average Data for each variable per Activity and Subject ")
TidyDataTemp <- melt(TidyData, id=c("Activity", "Subject"), measure.vars=select)
TidyDataAverage <- dcast(TidyDataTemp, Activity + Subject ~ variable, mean)
message("Creation of Tidy Average Data completed.")

# Write Tidy Data and Tidy Average Data
message("Writing Tidy Data and Tidy Average Data")
write.table(TidyData, file="./TidyData.txt", row.names=FALSE)
write.table(TidyDataAverage, file="./TidyDataAverage.txt", row.names=FALSE)
message("Writing of Tidy Data and Tidy Average Data completed.")