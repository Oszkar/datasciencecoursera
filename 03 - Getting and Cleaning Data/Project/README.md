Getting and Cleaning Data Course Project: UCI HAR Dataset Analysis
========================

A repo for Coursera's Data Science Signature Track's programming assignment.

##### Date

December 2014 - *[ongoing]*

##### author
Oszkar Jozsa - [website] [site] - [twitter] [twitter]

## Tasks

Project tasks were to analyze the [UCI HAR Dataset] [dataset] and convert it into a tidy data set.

#### Detailed tasks

You should create one R script called run_analysis.R that does the following. 

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## R code

All the code can be found in [run_analysis.R](run_analysis.R) file.

## Data

The code above assumes that you have the UCI HAR Dataset folder in your directory. This repo does not cointain the dataset due to its size. The final, processed, tidy data set specified by the project tasks can be found in the [tidy_data_set.txt](tidy_data_set.txt) text file.

## Data codebook

You can find the codebook in the [codebook](CodeBook.md) file.

[site]:http://jozsaoszkar.com
[twitter]:https://twitter.com/wasteproduct/
[dataset]:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones