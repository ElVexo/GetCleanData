## R Script for Getting and Cleaning Data class Course Project.

# Load required libraries
library(dplyr)
library(tidyr)

## Step 1: Merges the training and the test sets to create one data set.

# Load raw data
test_data_raw <- read.csv("test/X_test.txt", header = FALSE, sep = "")
train_data_raw <- read.csv("train/X_train.txt", header = FALSE, sep = "")

# Merge data sets into a single data frame tbl.
all_data_raw <- bind_rows(test_data_raw, train_data_raw)

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

# Load features file to get a list of all the column labels for the raw data.
features <- read.csv("features.txt", header = FALSE, sep = "")

# Subset the features to only include mean() and std() values.
mean_std_features <- filter(features, grepl('mean|std', V2))

# Subset raw data with only the columns containing mean() and std() values.
mean_std_raw <- select(all_data_raw, mean_std_features[, 1])

## Step 3: Uses descriptive activity names to name the activities in the data set.

# Load test and train labels.
test_labels <- read.csv("test/y_test.txt", header = FALSE, sep = "")
train_labels <- read.csv("train/y_train.txt", header = FALSE, sep = "")

# Merge them together into a single data frame tbl.
all_labels <- bind_rows(test_labels, train_labels)

# Load activity labels.
activity_labels <- read.csv("activity_labels.txt", header = FALSE, sep = "")

# Update labels with activity descriptions.
merged_labels <- merge(all_labels, activity_labels, by.x = "V1", by.y = "V1", sort = FALSE)

# Combine labels with raw data
merged_data <- tbl_df(cbind(merged_labels[, 2], mean_std_raw))

## Step 4: Appropriately labels the data set with descriptive variable names. 

# Manually label the activity column.
colnames(merged_data)[1] <- "Activity"

# Strip parentheses from features names.
mean_std_features$V2 <- gsub("[()]", "", mean_std_features$V2)

# Assign labels to remain columns based on descriptions from the features data.
colnames(merged_data)[2:80] <- mean_std_features[, 2]

## Step 5: From the data set in step 4, creates a second, independent tidy data set with 
##         the average of each variable for each activity and each subject.

# Load subject data.
subject_test <- read.csv("test/subject_test.txt", header = FALSE, sep = "")
subject_train <- read.csv("train/subject_train.txt", header = FALSE, sep = "")

# Merge subject data into a single data frame tbl.
all_subjects <- bind_rows(subject_test, subject_train)

# Combine subjects with merged data
merged_data <- tbl_df(cbind(all_subjects, merged_data))

# Manually label the subjects column.
colnames(merged_data)[1] <- "Subject"

# Create a tidy data set grouping by Subject and Activity and taking the mean of every other column.
tidy_data <- merged_data %>% group_by(Subject, Activity) %>% summarize_each(funs(mean(., na.rm=TRUE)))

## Export the tidy data set as a text file.
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)