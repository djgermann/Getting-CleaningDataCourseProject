#README

## General Information

This README contains a brief description of 
* the files created for the project assignment of the Data Sience course Getting And Cleaning Data
* the instructions how to run the code

## File Summary

* README.md: This file

* run_analysis.R: Code to read in original data, compute summary statistics and write out this data set to file

* DataSummary.txt: Text file containing the summary data set

* CodeBook.md: Code book with bried description of the summary data set


## Code Instructions

To run the script run_analysis.R following prerequisites are required

* packages dplyr and stats need to be installed and loaded
* The data set https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip needs to be downloaded and unpacked in the working directory with the top most folder being UCI HAR Dataset

The script performs following steps

* Step 0: load packages and read in data
* Step 1: Merge the training and the test sets to create one data set
* Step 2: Extract only the measurements on the mean and standard deviation for each measurement
* Step 3: Use descriptive activity names and add these to data set together with subject information
* Step 4: Appropriately label the data set with descriptive variable names (these are just taken over from the original data) 
* Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
* Step 6: Write the new data set to a text file