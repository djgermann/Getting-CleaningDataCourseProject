################################################################################
# load packages
################################################################################

library(dplyr)
library(stats)

################################################################################
# Read in data
################################################################################
# data needs to be in working directory in same folder structure as downloaded
# from the source destination

fileTestData <- "./UCI HAR Dataset/test/X_test.txt"
fileTestActivity <- "./UCI HAR Dataset/test/Y_test.txt"
fileTestSubject <- "./UCI HAR Dataset/test/subject_test.txt"

fileTrainData <- "./UCI HAR Dataset/train/X_train.txt"
fileTrainActivity <- "./UCI HAR Dataset/train/Y_train.txt"
fileTrainSubject <- "./UCI HAR Dataset/train/subject_train.txt"

fileVariableLabel <- "./UCI HAR Dataset/features.txt"
fileActivityLabel <- "./UCI HAR Dataset/activity_labels.txt"

dataTest <- read.table(fileTestData)
activityTest <- read.table(fileTestActivity)[,1]
subjectTest <- read.table(fileTestSubject)[,1]

dataTrain <- read.table(fileTrainData)
activityTrain <- read.table(fileTrainActivity)[,1]
subjectTrain <- read.table(fileTrainSubject)[,1]

labelVariable <- read.table(fileVariableLabel)
labelActivity <- read.table(fileActivityLabel)

################################################################################
# Step 1: Merge the training and the test sets to create one data set.
################################################################################

dataAll <- bind_rows(dataTrain, dataTest)
rm (dataTest, dataTrain) #remove test and training data to free up memory

################################################################################
# Step 2: Extract only the measurements on the mean and standard deviation for 
# each measurement. 
################################################################################

idxMeanStd <- c(grep("mean", labelVariable[,2]), grep("std", labelVariable[,2]))
dataAllReduced <- select(dataAll, idxMeanStd)

################################################################################
# Step 3: Use descriptive activity names and add these to data set together with 
# subject information
################################################################################
# creating arrays on subject and activity 
arrSubject <- c(subjectTrain, subjectTest)
arrActivity <- c(activityTrain, activityTest)

# translate activity codes into descriptive names
arrActivity <- sapply(arrActivity, function(idxAct) labelActivity[idxAct,2])

# add activity and subject info to data set
dataAllReduced <- mutate(dataAllReduced, Activity = arrActivity, 
                         Subject = arrSubject)

################################################################################
# Step 4: Appropriately label the data set with descriptive variable names. 
################################################################################

names(dataAllReduced) <- c(as.character(labelVariable[idxMeanStd, 2]), 
                           "Activity", "Subject")

################################################################################
# Step 5: Create a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
################################################################################

#removing Activity and Subject from data set as NAs produced otherwise
dataSummary <- aggregate(select(dataAllReduced, -c(Activity, Subject)), 
                         list(Activity = dataAllReduced$Activity, 
                            Subject = dataAllReduced$Subject), mean)

################################################################################
# Step 6: Write the new data set to a text file
################################################################################

write.table(dataSummary, file = "DataSummary.txt", row.name=FALSE)