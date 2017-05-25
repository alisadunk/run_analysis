## Feature Selection 

There 2 new variables added to both tidy data sets:

* subject (number of subjects: 1 to 30)
* NameActivity (descriptive activity names: 1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

## Variables 

* trainx, trainy, testx, testy, subjectrain and subjectest contain the data from the downloaded files.
* trainxtestx, trainytestz merge the previous datasets to further analysis.

## R Script

File with R code "run_analysis.R" perform 5 following steps (in accordance assigned task of course work):

- Merging the training and the test sets to create one data set.
- Extracting only measurements on the mean and standard deviation for each measurement
- Using descriptive activity names to name activities
- Labeling the data set with descriptive variable names
- Creation of an independent tidy data set with the average of each variable for each activity and each subject

