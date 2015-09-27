# Getting and Cleaning Data Project

## Introduction
This repository contains the completed course project for the Getting and Cleaning Data course.

The repository contains four project files, detailed below.

## Repository Files

### READMME.md
This file, providing an explanation of the project and the files within the repository.

### run_analysis.R
The R source code file which satisfies the following project requirements:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To run the script, download it into a working directory along with the root of the raw data files, and execute the following command:

```r
source('./run_analysis.R')
```

### tidy_data.txt
This file contains the cleaned and tidied data and is the final export of the run_analysis.R script.  It can be viewed by downloading into
a working directory and executing:

```r
data <- read.table('./tidy_data.txt', header = TRUE)
View(data)
```
### CodeBook.md
The CodeBook details the columns of the tidy_data.txt final output file.

## Process
The run_analysis.R script performs the following steps in order to satisfy the project requirements:

1. Load the dplyr and tidyr libraries.
2. Load the raw test and train data into two data tables: test_data_raw and train_data_raw
3. Merge the two data sets into a single data frame tbl: all_data_raw
4. Load the features file to get a list of all the column labels for the raw data: features
5. Subset the features to only include mean() and std() values: mean_std_features
6. Subset the raw data with only the columns containing mean() and std() values: mean_std_raw
7. Load the test and train labels data: test_labels and train_labels
8. Merge the labels data into a single data frame tbl: all_labels
9. Load the activity labels: activity_labels
10. Update the labels with activity descriptions: merged_labels
11. Combine the labels with the raw data: merged_data
12. Manually label the activity column.
13. Strip parentheses from features names for readability.
14. Assign labels to the remaining columns based on descriptions from the features data.
15. Load the subject data: subject_test and subject_train
16. Merge subject data into a single data frame tbl: all_subjects
17. Combine subjects data with merged data: merged_data
18. Manually label the subjects column.
19. Create a tidy data set grouping by Subject and Activity and taking the mean of each of the data columns: tidy_data
20. Export the tidy data set as a text file.