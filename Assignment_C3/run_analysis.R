

# The script:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

library(dplyr)

filename <- "getdata_projectfiles_UCI_HAR_Dataset.zip"

# Checking if archive already exists, downloading if not
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists and unzipping if not
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}
setwd("UCI HAR Dataset")

# loading description files
activity_labels <- read.table(".\\activity_labels.txt")
head(activity_labels)
colnames(activity_labels) <- c("id", "activity")

features <- read.table(".\\features.txt")
head(features)
colnames(features) <- c("id", "feature")

# Select only features containing "mean" or "std"
target_features <- grep("(mean|std)", features[, "feature"])
head(target_features)

# Subsetting data to carry along only target fratures
sel_data <- train[,target_features]

# Removing parentheses from feature names
target_features <- features[target_features,]
measurements <- gsub('[()]', '', target_features[, "feature"])
head(measurements)


# Loading training data

train <- read.table(".\\train\\X_train.txt")
head(train)
train_subj <- read.table(".\\train\\subject_train.txt")
head(train_subj)
train_act <- read.table(".\\train\\y_train.txt")
head(train_act)


# Merging subjects column with subset data, assigning descriptive names to variables
merge_train <- cbind(train_subj, train_act, sel_data)
colnames(merge_train) <- c("subject", "activity", measurements)
head(merge_train)
tidy_train <- mutate(merge_train, "group" = "train", .after = activity)
head(tidy_train)

# Loading test data

test <- read.table(".\\test\\X_test.txt")
head(test)
test_subj <- read.table(".\\test\\subject_test.txt")
head(test_subj)
test_act <- read.table(".\\test\\y_test.txt")
head(test_act)

sel_test <- test[,target_features]

test_act <- read.table(".\\test\\y_test.txt")

# Merging subjects column with subset data, assigning descriptive names to variables
merge_test <- cbind(test_subj, test_act, sel_test)
colnames(merge_test) <- c("subject", "activity", measurements)
head(merge_test)
tidy_test <- mutate(merge_test, "group" = "test", .after = activity)
head(tidy_test)

merged_data <- rbind(tidy_train, tidy_test)


# Label activites with the provided activity labels

merged_data[["activity"]] <- factor(merged_data[, "activity"],
                                    levels = activity_labels[["id"]],
                                    labels = activity_labels[["activity"]]
                                    )
merged_data[["activity"]]

merged_data[["subject"]] <- as.factor(merged_data[,"subject"])
merged_data[["group"]] <- as.factor(merged_data[,"group"])

avg_data <- merged_data %>% group_by(activity, subject) %>% summarize_all(funs(mean)) 

write.table(avg_data, file="avg_data.txt")







