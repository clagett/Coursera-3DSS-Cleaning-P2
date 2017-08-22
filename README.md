# Getting and Cleaning Data - Course Project

Dataset used: Human Activity Recognition Using Smartphones

A full description of the data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data for this project can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Files

run_analysis.R: Contains the code needed to perform the data cleasing that was described in the five steps on the coursera project web page. The test data, train data, and data about subjects and activities performed are loaded and bound into one table using rbind(). Activities and column names are renamed appropriately. The data is then grouped by subject and activity and averaged.

CodeBook: This file contains information about the data used, as well as variables written in the R file run_analysis.R.

