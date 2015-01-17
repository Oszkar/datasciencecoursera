## 1. Merges the training and the test sets to create one data set.

# training data
train_x <- read.table("UCI HAR Dataset//train/X_train.txt", nrows=7352, comment.char="")
train_sub <- read.table("UCI HAR Dataset//train/subject_train.txt", col.names=c("subject"))
train_y <- read.table("UCI HAR Dataset/train//y_train.txt", col.names=c("activity"))
train_data <- cbind(train_x, train_sub, train_y)

# test data
test_x <- read.table("UCI HAR Dataset//test/X_test.txt", nrows=2947, comment.char="")
test_sub <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subject"))
test_y <- read.table("UCI HAR Dataset/test//y_test.txt", col.names=c("activity"))
test_data <- cbind(test_x, test_sub, test_y)

# merge training and test 
data <- rbind(train_data, test_data)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# read in the column names and add "subject" and "activity" as we'll need these later
column_names <- read.table("UCI HAR Dataset//features.txt", col.names = c("id", "name"))
column_names <- rbind(column_names, data.frame(id=nrow(column_names)+1, name="subject"))
column_names <- rbind(column_names, data.frame(id=nrow(column_names)+1, name="activity"))

# grepl("std|mean", column_names[,2]) will give us all the column names that contain "mean" or "std" in them
# we also have to keep subject and activity
# and save the IDs that remain after filtering
filtered_ids = column_names[grepl("std|mean|subject|activity", column_names[,2]),]$id
tidy_data = data[, filtered_ids]

## 3. Uses descriptive activity names to name the activities in the data set

# read in labels
activity_labels <- read.table("UCI HAR Dataset//activity_labels.txt", col.names=c("id", "name"))
# go through each activity and replace the corresponding activity ID with the
# textual name we juse read in
for (i in 1:nrow(activity_labels)) {
  tidy_data$activity[tidy_data$activity == activity_labels[i, "id"]] <- as.character(activity_labels[i, "name"])
}

## 4. Appropriately labels the data set with descriptive variable names.

# we already have the names in column_names
names(tidy_data) <- column_names[filtered_ids,2]

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# remove the last two columns (subject and activity) as they are not subject of the mean
tmp <- tidy_data[, 1:(ncol(tidy_data)-2)]
output <- aggregate(tmp,list(tidy_data$subject, tidy_data$activity), mean)
# add human readable name to the first two columns
names(output)[1] <- "subject"
names(output)[2] <- "activity"

# finally, save the files
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
write.table(output, "tidy_data_set.txt", row.name=FALSE)