---
title: "Final-Assignment-Getting-and-cleaniing-data"
author: "FLM"
date: "12/10/2021"
output: html_document
---
# Getting-and-Cleaning-Data-Week-4-Assignment

This repository contains the submission for the assignment for week 4 of Getting and Cleaning Data Coursera course.
You will be required to submit: 
1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
You should also include a README.md in the repo with your scripts. 

This repo explains how all of the scripts work and how they are connected.
•First, download and unzip the data file into your R working directory.
•Second, download the R source code into your R working directory.
•Finally, execute R source code to generate tidy data file.

# Data description
The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. The variable in the data Y indicates activity type the subjects performed during recording.
The dataset "avg_data" contains 180 observations in 82 variables.

# Code explaination
The code generates a new dataset resulting from the merging of a train and a test dataset. One variable was added and named "group" to distinguish from what original dataset each item came from.
The variables were originally selected to extract only those accounting for mean and standard deviation of the target measures.

# New dataset
The new generated dataset contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.

The code was written based on the instruction of this assignment:
The script:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


