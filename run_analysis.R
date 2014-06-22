# load the required libraries
library(reshape2)
library(stats)

# Set the working Directory
setwd("D:/myWork/R Files/Repo/DataScience/Getting and Cleaning Data/Course Project")

# Download the data from the URL
fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Set a name for the file and download
local_name <- "UCI HAR Dataset.zip"
download.file(url=fileurl,dest=local_name)

# Unizip the donwloaded file
unzip(local_name)

# Load the test files into dataframes
subjecttestdf <- read.table("UCI HAR Dataset/test/subject_test.txt", comment = "",col.names = "subjectid", colClasses="numeric")
xtestdf <- read.table("UCI HAR Dataset/test/X_test.txt", comment = "", colClasses = "numeric")
ytestdf <- read.table("UCI HAR Dataset/test/y_test.txt", comment = "", colClasses = "numeric", col.names = "activityid")

# Load the features file containing the name of columns for xtestdf into a dataframe
featuresdf <- read.table("UCI HAR Dataset/features.txt", comment = "")

# Assign names from features dataframe to xtestdf by converting features to character vector
names(xtestdf) <- as.vector(featuresdf$V2)

# create logical vector to extract the mean and std related columns
colextractor <- grepl('-mean\\(\\)|-std\\(\\)', names(xtestdf))

# create a new test dataframe with req cols (mean and std)
testdata <- xtestdf[, colextractor]

# Concatenate subjecttestdf, testdata, and ytestdf into a single dataframe
testdf <- cbind(subjecttestdf, cbind(ytestdf, testdata))

# Load the train files into dataframes
subjecttraindf <- read.table("UCI HAR Dataset/train/subject_train.txt", comment = "",col.names = "subjectid", colClasses="numeric")
xtraindf <- read.table("UCI HAR Dataset/train/X_train.txt", comment = "", colClasses = "numeric")
ytraindf <- read.table("UCI HAR Dataset/train/y_train.txt", comment = "", colClasses = "numeric", col.names = "activityid")

# Assign names from features dataframe to xtraindf by converting features to character vector
names(xtraindf) <- as.vector(featuresdf$V2)

# create logical vector to extract 
colextractor <- grepl('-mean\\(\\)|-std\\(\\)', names(xtraindf))

# create a new train dataframe with req cols (mean and std)
traindata <- xtraindf[, colextractor]

# Concatenate subjecttraindf, traindata, and ytestdf into a single dataframe
traindf <- cbind(subjecttraindf, cbind(ytraindf, traindata))

# rbind the test and train data
combineddata <- rbind(traindf, testdf)

# Load the activity labels into a dataframe and name the columns
activitylables <- read.table("UCI HAR Dataset/activity_labels.txt", comment = "")
names(activitylables) <- c("activityid", "activityname")

# Merge the activitylabels with the combineddata basd on activity id
mergeddata <- merge(activitylables, combineddata, by.x = "activityid", by.y = "activityid")

# Rename the variable names by converting "-" to "."
modnames <- function(x) {
  gsub("-", ".", x[1])
}
names(mergeddata) <- sapply(names(mergeddata), modnames)

# Remove the activity id since the activity name refers to the same thing but is much more descriptive
mergeddata$activityid <- NULL

# Summarize the data set from the above step to take the mean for each subject and activity combination
tidydata <- aggregate(data = mergeddata, .~subjectid+activityname, FUN = mean)

# Output the tidy data to a text file
write.table(tidydata, file="tidydata.txt", col.names=colnames(tidydata))

# Remove temporary vectors/dataframes from the workspace to free up the memory
rm(subjecttestdf, xtestdf, ytestdf, testdata)
rm(subjecttraindf, xtraindf, ytraindf, traindata)
rm(featuresdf, colextractor)
rm(traindf, testdf)
rm(combineddata, activitylables)
rm(mergeddata)