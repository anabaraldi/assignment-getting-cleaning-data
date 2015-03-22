library(dplyr)

# Step 1: Merges the training and the test sets to create one data set.

testSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

completeSet <- rbind(testSet, trainSet)
completeLabel <- rbind(testLabel, trainLabel)
completeSubject <- rbind(testSubject, trainSubject)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
selectedFeatures <- grep("mean\\(\\)|std\\(\\)", features[,2])
completeSet <- completeSet[,selectedFeatures]
names(completeSet) <- features[selectedFeatures, 2]

# Step 3: Uses descriptive activity names to name the activities in the data set
activityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt")
completeLabel <- activityLabel[completeLabel[,1],2]
names(completeLabel) <- "activity"

# Step 4: Appropriately labels the data set with descriptive variable names. 
names(completeSubject) <- "subject"
cleanedSet <- cbind(completeSubject, activity = completeLabel, completeSet)

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
groupedSet <- group_by(cleanedSet, activity, subject)
tidyData <- summarise(groupedSet, colMeans(groupedSet[3]))
names(tidyData) <- c("activity", "subject", names(cleanedSet[3]))
for(i in 4:ncol(cleanedSet)) {
    x <- summarise(groupedSet, colMeans(groupedSet[i]))
    names(x) <- c("activity", "subject", names(cleanedSet[i]))
    tidyData <- merge(tidyData, x)
}
write.table(tidyData, file="./tidyData.txt", row.name=FALSE)