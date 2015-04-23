##Getting and Cleaning Data Project  
##Assume the required files are in the working directory
##load libraries
library(dplyr)
library(reshape2)

##read in the three text files from the train folder and the features file

subject_train <-read.table("./train/subject_train.txt", col.names = 
                             "Subject", colClasses="numeric")
X_train <-read.table("./train/X_train.txt", colClasses = rep("numeric", 561))
y_train <-read.table("./train/y_train.txt", col.names = "Activity", colClasses="factor")
features <-read.table("./features.txt",stringsAsFactors = FALSE )

##Repeat for test data set

subject_test <-read.table("./test/subject_test.txt", col.names = "Subject", colClasses="numeric")
X_test <-read.table("./test/X_test.txt",colClasses = rep("numeric", 561))
y_test <-read.table("./test/y_test.txt", col.names = "Activity", colClasses="factor")

##remove the first column from features

features <-features[,"V2"]

##modify features so that subject and activity columns are added
##change the variables that contain -mean() and -std() to just mean and std
##make everything lowercase

features <- append(features, values =c("Subject", "Activity"))
features <- gsub("-mean()", "Mean", features, fixed = TRUE)
features <- gsub("-std()", "Std", features, fixed = TRUE)
features <- tolower(features)

##merge the train and test datasets together 

train_data <-cbind(X_train, subject_train, y_train)
test_data <-cbind(X_test, subject_test, y_test)
all_data <- rbind( train_data, test_data)

##assign the column variable names of all_data from features
colnames(all_data)=features


##remove duplicated columns
all_data <- all_data[ !duplicated(names(all_data)) ]

##I interpreted part 2 as to only take the column variable names that ended with mean or std
##Also include the subject and activity columns
data_extract <-select(all_data, ends_with("mean"), ends_with("std"), 
                      contains("subject"), contains("activity"))

##The data was sorted by subject number
data_extract <-arrange(data_extract, subject)

##The activities were changed from numbers to descriptions
levels(data_extract$activity)<-c("Walking", "Walking_Upstairs", "Walking_Downstairs",
                                 "Sitting", "Standing", "Laying" )

##made a new character vector of the variable names, not including activity and subject
c<- names(data_extract)
c <- c[1:18]

##reshaped the data with subject and activity as id and all the other variables as measurments
data_melt <- melt(data_extract, id= c("subject", "activity"), 
                  measure.vars=c)

##created a tidy data set that has the average of each variable for each subject and activity
tidy_data <- dcast(data_melt, subject+activity~variable,mean)

##create text file of the tidy data
write.table(tidy_data, file = "tidy_data.txt", row.names=FALSE)