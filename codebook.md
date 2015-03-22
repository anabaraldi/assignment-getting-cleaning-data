---
title: "codeBook.md"
author: "Ana Baraldi"
date: "March 22, 2015"
output: html_document
---

Getting and Cleaning Data Course Project CodeBook
=================================================

This file describes the variables, the data and the transformation to get the Tidy Data output.

* The site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      

* The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* The run_analysis.R script performs the following steps to clean the data:   
1) The first step is read the data we will need with the function read.table we will read the train folders from the "./UCI HAR Dataset/train" and the test folders from the "./UCI HAR Dataset/test": 
    a) *X_train.txt*, *y_train.txt* and *subject_train.txt* and store each dataset in *trainSet*, *trainLabel* and *trainSubject*       variables respectively.       
    b) *X_test.txt*, *y_test.txt* and *subject_test.txt* and store each dataset in *testSet*, *testLabel* and *testsubject* variables respectively.  
2) The next step is too merge the train and test values. So it will be necessary to concatenate *testSet* to *trainSet* to generate a 10299x561 data frame called *completeSet*; concatenate *testLabel* to *trainLabel* to generate a 10299x1 data frame called *completeLabel*; concatenate *testSubject* to *trainSubject* to generate a 10299x1 data frame called *completeSubject*.
3) We won't work with all the measurements, we will only use the ones that have *mean* and *standard deviation* measures. To subset our data we will read the *features.txt* file to know the columns to select the measurements and then do the subset in *completeSet* to select the columns we want.
4) To know the activity we need to read the *activity_labels.txt* file from the "./UCI HAR Dataset" folder and store the data in a variable called *activityLabel*. 
5) Transform the values of *completeLabel* according to the *activityLabel* data frame.
6) Combine the *completeSubject*, *completeLabel* and *completeSet* by column to get a new cleaned 10299x68 data frame, *cleanedSet*. Properly name the first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.
7) Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. The way we chose to build our tidy data was from grouping the *cleanedSet* by *activity* and then by *subject*, after doing this we take the mean for each colunm with a for looping and store the result in a new data frame called *tidyData*.
8) Write the *tidyData* out to "tidyData.txt" file in current working directory. 


