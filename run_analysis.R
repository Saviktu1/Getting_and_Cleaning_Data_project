#Initializing necessary packages
#utils for unzipping downloaded .zip file
library(utils)

#data.table package for faster data processing
library(data.table)

#dplyr for manipulating data frame or data table
library(dplyr)

#tidyr for splitting and tidying dataset
library(tidyr)

#reshape2 for finalizing tidy dataset
library(reshape2)

#Download .zip file from source
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "Project_dataset.zip", mode="wb")

#Unzipping file to working directory
unzip("Project_dataset.zip", overwrite=TRUE)

#Reading all the necessary files conserning training data
#Subject id
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",sep="\n",col.names="Subject")

#Activity id
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",sep="\n",col.names="Activity")

#Measurements for every subject and activity
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")

#Combining data frames with cbind function
train <- as.data.frame(cbind(subject_train,y_train,X_train))

#Reading all the necessary files conserning test data
#Subject id
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",sep="\n",col.names="Subject")

#Activity id
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",sep="\n",col.names="Activity")

#Measurements for every subject and activity
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")

#Combining data frames with cbind function
test <- as.data.frame(cbind(subject_test,y_test,X_test))

#Reading activity labels
activity_l <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("Activity","Activity_Names"))

#Reading variable names
features <- read.table("UCI HAR Dataset/features.txt", col.names=c("Order_of_Feature","Feature_Name"))

#Combining training and test datasets with rbind, test dataset has 9 subjects, training dataset has 21 subjects.
combined <- rbind(train, test)

#Filtering mean and standard deviation measurements from features dataset.
#Filtering considers only mean() and std() functions, not meanFreq() function because it's said that
#you should only take mean and standard deviation values for each measurement and meanFreq() is it's own variable. 
features_used <- features[c(grep("std()",features$Feature_Name,fixed=TRUE),
                            grep("mean()",features$Feature_Name,fixed=TRUE)),]

#Removing special characters "()" from variable names.
#Removing error in variable name, "BodyBody", and replacing it with "Body".
#Adding "_" special character between variable name and measurement type.
#Result and order of variable names after manipulation is following: 
# 1. Variable name
# 2. Measurement name
features_used <- mutate(features_used,Feature_Name = gsub("[()]","",Feature_Name),
                                      Feature_Name = gsub("-","_",Feature_Name),
                                      Feature_Name = gsub("BodyBody","Body",Feature_Name),
                                      Feature_Name = gsub("_mean_X","X_mean",Feature_Name),
                                      Feature_Name = gsub("_mean_Y","Y_mean",Feature_Name),
                                      Feature_Name = gsub("_mean_Z","Z_mean",Feature_Name),
                                      Feature_Name = gsub("_std_X","X_std",Feature_Name),
                                      Feature_Name = gsub("_std_Y","Y_std",Feature_Name),
                                      Feature_Name = gsub("_std_Z","Z_std",Feature_Name))

#Selecting relevant columns by using features_used table created earlier.
#In that table you have a column named Order_of_Feature which indicates the order of variables
#in the X_train and X_test files. Because those data frames are combined with files containing 
#subject and activity id it's possible to select relevant mean and std columns by using 
#value of Order_of_Feature column in the features_used table by adding value 2 to it.
combined <- combined[,c(1,2,features_used$Order_of_Feature+2)]

#When mean and std columns are selected then it's possible by using colnames function, when 
#filtering columns Subject and Activity id away, to add variable names to dataset.
colnames(combined)[-c(1,2)] <- features_used$Feature_Name

#Adding activity labels to dataset
combined <- merge(combined, activity_l, by="Activity", all.x=TRUE)

#Reordering dataset so that subject and activity label are first two columns in dataset.
#Activity id is dropped.
combined <- combined[,c(2,ncol(combined),3:(ncol(combined)-1))]

#Creating, basically just for fun, data table to make next functions more faster to compute.
combined <- as.data.table(combined)

#By chaining functions of tidyr package, dataset is manipulated so that eachfeature is in
#it's own row and measurements are in one column.
comb_res <- 
  combined %>% 
  gather(Feature_Name, Value, -c(Subject,Activity_Names)) %>% 
  separate(Feature_Name, c("Feature","Measure"), sep="_")

#Last phase is to take average of each variable for each activity and each subject so that mean
#and std are both in their own columns.
comb_res <- dcast.data.table(comb_res, Subject + Activity_Names + Feature ~ Measure, mean)

#Taking text file out to attach it to coursera platform.
write.table(comb_res, "data.txt", row.names=FALSE)
