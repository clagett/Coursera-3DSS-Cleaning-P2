# Downloading and unzipping the files

UCIzip <- "UCIdata.zip"

if(!file.exists(UCIzip)){
     fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     download.file(fileURL, destfile=UCIzip, method = "curl")
}
if(!file.exists("UCI HAR Dataset")){
     unzip(UCIzip)
}

# Loading datasets
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# Converting features to character strings in order to extract mean and standard deviation
features[,2] <- as.character(features[,2])
activityLabels[,2] <- as.character(activityLabels[,2])

# Extracting the names that include mean and standard deviation
meanstd <- grep(".mean|.std", features[,2])

# Loading the data for the mean and std in training and test datasets, 
# and binding the activity labels and subject IDs to each
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")[meanstd]
trainLabels <- read.table("UCI HAR Dataset/train/Y_train.txt") 
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt") 
trainData <- cbind(trainSubjects, trainLabels, trainData)

testData <- read.table("UCI HAR Dataset/test/X_test.txt")[meanstd]
testLabels <- read.table("UCI HAR Dataset/test/Y_test.txt") 
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt") 
testData <- cbind(testSubjects, testLabels, testData)

#Binding the datasets
testtrain <- rbind(testData, trainData)

# Cleaning up column names and reassigning names to columns
meanstdNames <- grep(".mean|.std", features[,2], value=TRUE)
meanstdNames <- gsub('[-()]', '', meanstdNames) 
meanstdNames <- gsub("mean", "_Mean", meanstdNames) 
meanstdNames <- gsub("std", "_Std", meanstdNames)
colnames(testtrain) <- c("Subject", "Activity", meanstdNames)

# Applied function that replaces numeric values with activity names in the activityLabels data
testtrain[ ,2] <- as.factor(sapply(testtrain[ ,2], function(x){
     as.character(activityLabels$V2[match(x, activityLabels$V1)])
}))
testtrain[,1] <- as.factor(testtrain[,1])


# Aggregating the data by Subject and Activity, taking the means of each grouped value
library(dplyr)
tidy <- testtrain %>%
     group_by(Subject, Activity) %>% 
     summarise_all(funs(mean))

