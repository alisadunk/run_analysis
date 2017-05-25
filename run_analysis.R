download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile='courseradata.zip')
unzipfile <- unzip("courseradata.zip")
setwd('/Users/Louis/Documents/TESTTES/UCI HAR Dataset/train')
trainx <- read.table("X_train.txt")
trainy <- read.table("Y_train.txt")
subjectrain <- read.table("subject_train.txt")
setwd('/Users/Louis/Documents/TESTTES/UCI HAR Dataset/test')
testx <- read.table("X_test.txt")
testy <- read.table("Y_test.txt")
subjectest <- read.table("subject_test.txt")
setwd('/Users/Louis/Documents/TESTTES/UCI HAR Dataset')

#Question 1 - Merge datasets: trainx & testx
trainxtestx <- rbind(trainx, testx)


# Question 4 - Rename variables
colnames <- read.table("features.txt")
varnames <- colnames[,2]
varnames <- as.vector(varnames)
vartrainxtestx <- names(trainxtestx)
#for loop to rename variables
for(i in 1:561){
        names(trainxtestx)[names(trainxtestx)==vartrainxtestx[i]]=varnames[i]
}

#Question 2 - Extracts measurements: mean, standard deviation for each measurement
colmean <- grep('mean', names(trainxtestx))
colstd <- grep('std', names(trainxtestx))
colmeanstd <- trainxtestx[, c(colmean,colstd)]

#merge trainy & testy in order to use
#descriptive activity names to name the activities in the data set (trainxtestx)
trainytesty <- rbind(trainy, testy)

# Question 3 - Replace numbers 1:6 to WALKING,WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
trainytesty$V1 <- sub('1', 'WALKING', trainytesty$V1)
trainytesty$V1 <- sub('2', 'WALKING_UPSTAIRS', trainytesty$V1)
trainytesty$V1 <- sub('3', 'WALKING_DOWNSTAIRS', trainytesty$V1)
trainytesty$V1 <- sub('4', 'SITTING', trainytesty$V1)
trainytesty$V1 <- sub('5', 'STANDING', trainytesty$V1)
trainytesty$V1 <- sub('6', 'LAYING', trainytesty$V1)

#Creation of a new column for the activities names
trainxtestx$NameActivity <- trainytesty$V1

#Question 5 - Independent tidy data set
setwd('/Users/Louis/Documents/TESTTES/UCI HAR Dataset/train')
trainx <- read.table("X_train.txt")
trainy <- read.table("Y_train.txt")
subjectrain <- read.table("subject_train.txt")
setwd('/Users/Louis/Documents/TESTTES/UCI HAR Dataset/test')
testx <- read.table("X_test.txt")
testy <- read.table("Y_test.txt")
subjectest <- read.table("subject_test.txt")
setwd('/Users/Louis/Documents/TESTTES/UCI HAR Dataset')
# Merge datasets: trainx & testx
trainxtestx <- rbind(trainx, testx)

# Merge trainy & testy in order to use
# descriptive activity names to name the activities in the data set (trainxtestx)
trainytesty <- rbind(trainy, testy)

#Replace numbers 1:6 to WALKING,WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
trainytesty$V1 <- sub('1', 'WALKING', trainytesty$V1)
trainytesty$V1 <- sub('2', 'WALKING_UPSTAIRS', trainytesty$V1)
trainytesty$V1 <- sub('3', 'WALKING_DOWNSTAIRS', trainytesty$V1)
trainytesty$V1 <- sub('4', 'SITTING', trainytesty$V1)
trainytesty$V1 <- sub('5', 'STANDING', trainytesty$V1)
trainytesty$V1 <- sub('6', 'LAYING', trainytesty$V1)

# New column for Activities Names
trainxtestx$NameActivity <- trainytesty$V1

# New column for Subjects
subjectraintest <- rbind(subjectrain, subjectest)
subjectraintest$V1 <- subjectraintest[order(subjectraintest$V1),]
trainxtestx$subject <- subjectraintest$V1

# Use pf dplyr
library(dplyr)
tidydata <- group_by(trainxtestx, subject, NameActivity)
tidydatasum <- summarise_each(tidydata, funs(mean), V1:V561)
#for loop to rename variables
colnames <- read.table("features.txt")
varnames <- colnames[,2]
varnames <- as.vector(varnames)
vartrainxtestx <- names(trainxtestx)
for(i in 1:561){
        names(tidydatasum)[names(tidydatasum)==vartrainxtestx[i]]=varnames[i]
}

#Subset colomns with 'mean' and 'std'
colmean <- grep('mean', names(tidydatasum))
colstd <- grep('std', names(tidydatasum))
colnameactivity <- grep('NameActivity', names(tidydatasum))
colsubject <- grep('subject', names(tidydatasum))
tidydatafinal<- tidydatasum[, c(colmean, colstd, colnameactivity, colsubject)]