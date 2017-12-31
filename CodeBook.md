# CodeBook

This document describes the functionality of run_analysis.R (function) and assumes that the data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) has already been downloaded and unzipped in the working directory.

#Helper Functions

The function has 4 helper functions to keep the main code readable

## read_data

* This function makes a list of all files in working directory with extenstion ".txt" recursively, then removes the unnessary files.
* It then reads all files into one large data set (list)
* Then it applies appropriate labels to elements of the list

## simp_x

* This function finds the columns from features.txt that pertain to only the mean and sd
* It then replaces x_test & x_train elements of dat with these columns and labels them accordingly

##label_cols

*  This function simply labels the columns in the 2 subject_* & y_* elements in dat

## label_activities

* replaces the y_* elements of dat with the name of activity

#manipulation

After helper functions are complete the main function then manipulates the data:

* extracts _train & _test elements of dat into test & train data frames respectively
* combines test & train into one big data frame
* sets dat as a data frame
* outputs the average of each feature by subject & activity

#write results

* the file "results.txt" was created by the following code in Rstudio "write.table(run_analysis(), file="results.txt", row.names = FALSE)"
