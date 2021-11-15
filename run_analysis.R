# load libraries
library(dplyr) 

# set dataset directory
setwd("UCI HAR Dataset")

#read activity labels
activity_labels <- read.table("./activity_labels.txt")

# read train data 
x_train   <- read.table("./train/X_train.txt")
y_train   <- read.table("./train/y_train.txt") 
sub_train <- read.table("./train/subject_train.txt")

# read test data 
x_test   <- read.table("./test/X_test.txt")
y_test   <- read.table("./test/y_test.txt") 
sub_test <- read.table("./test/subject_test.txt")

# read features description 
features <- read.table("./features.txt")

# merge of training and test sets
x_total   <- rbind(x_train, x_test)
y_total   <- rbind(y_train, y_test) 
sub_total <- rbind(sub_train, sub_test) 

# Extract only measurements on mean and standard deviation
sel_features <- grep("(mean|std)", features[, 2])
x_total      <- x_total[,sel_features]

# Use descriptive activity names to name the activities in the data set.
total_data_y <- as.data.frame(activity_labels[y_total[, 1], 2])
colnames(total_data_y) <- "Activity"

# Appropriately labels the data set with descriptive variable names.
colnames(sub_total) <- "Subject"
total_data <- cbind(x_total, total_data_y, sub_total)

# From the data set above, create a second, independent tidy data set with the average of each variable for each activity and each subject.
total_mean <- total %>% group_by(activity, subject) %>% summarize_all(list(mean)) 

# export summary dataset
write.table(groupData, file = "TidyData.txt", row.names = FALSE, quote = FALSE)


