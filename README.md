# Course Project

Getting and Cleaning Data

## Introduction to the given task as it is written in Coursera portal

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Solution

The actual script is in repository Getting_and_Cleaning_Data_project named as run_analysis.R. There is also output dataset data.txt and original dataset in .zip file.

It does following:

1. It Initializes necessary packages which are
	1. utils -package for unzipping downloaded .zip file
	2. data.table -package for faster data processing
	3. dplyr -package for manipulating data frame or data table (Actually this package isn't used at all).
	4. tidyr -package for splitting and tidying dataset
	5. reshape2 -package for finalizing tidy dataset, calculating average for mean and standard deviation measures.

2. Script downloads .zip file from source stated in introduction.

3. It unzips file to working directory

4. It reads all training and test dataset as well as activity labels and feature names into R. In this assingment Inertial signal datasets are not used.
	Following text files are read by read.table function:
		1. subject_test.txt and subject_train.txt, contains subject id's each on it's own row.
		2. y_test.txt and y_train.txt, contains activity id's each on it's own row.
		3. X_test.txt and X_train.txt, contains variables for each subject and activity described in features_info.txt file
		4. features.txt, contains variable names in same order as they are in X_test.txt and X_train.txt files.
		5. activity_labels.txt, contains activity names for ids.

5. Script combines data frames with cbind function, training and test dataset separately. After that it combines training and test dataset by using rbind function.

6. Script uses features.txt to pick mean and standard deviation variables from combined dataset. It uses gsub function with expressions mean() and std(). meanFreq function isn't
by definition included to this as it is not created by mean() function explicitly.

7. After creating new dataset where there is only mean() and std() measures, script manipulates variable names so that it's possible to separate mean and standard deviation 
to different columns by using separate function from tidyr package. It erases special characters "()" from variable names and replaces "BodyBody" with "Body" expression.
Measurements, std or mean are splitted with "_" and are now postfixes. Result is [variable name]_[measurement_name].

8. Relevant columns are selected by using features_used table created earlier. In that table you have a column named Order_of_Feature which indicates the order of variables
in the X_train and X_test files. Because those data frames are combined with files containing subject and activity id it's possible to select relevant mean and std columns 
by using value of Order_of_Feature column in the features_used table by adding value 2 to it. When mean and std columns are selected then it's possible, by using colnames function,
add variable names to dataset.

9. Script adds activity labels to dataset. That is done with merge function. Merging reorders dataset so that key column, which is common to both merged datasets, is in first
column and other columns are at the end of dataset. Script makes some reordering so that Subject id and activity name are first two columns in data.

10. Script changes data frame to data table so that rest of script runs faster. There is no reason actually to do this but I'll do this anyway.

11. By chaining functions of tidyr package, dataset is manipulated so that each variable is in
it's own row and measurements are in one column.

12. Last phase is to take average of each variable for each activity and each subject so that mean
and std are both in their own columns.

13. Output of this script is a text file which is attached to coursera platform.

For details take a closer look of run_analysis.R file in Getting_and_Cleaning_Data_project repository.

CodeBook.md explains the data in more detail.


