library(data.table)
library(dplyr)

##read in pre-processed train and test data sets from "UCI HAR Dataset"
  data_train <- read.table("X_train.txt", header = FALSE, sep = "", dec = ".")
  data_test  <- read.table("X_test.txt", header = FALSE, sep = "", dec = ".")
  #read in subject identifiers
  subject_train <- read.table("subject_train.txt", header = FALSE)
  subject_test  <- read.table("subject_test.txt", header = FALSE)
  #read in activity labels
  activity_train <- read.table("y_train.txt", header = FALSE)
  activity_test  <- read.table("y_test.txt", header = FALSE)
  #read in activity labels
  activity_labels  <- read.table("activity_labels.txt", header = FALSE)
  # read in labels for train/test data set
  features  <- read.table("features.txt", header = FALSE, sep = "", dec = ".")

##merges the training and the test sets to create one data set
  data_train_test <- rbind(data_train, data_test)

##extracts only the measurements on the mean and standard deviation for each measurement. 
  feature_names <- grep("[Mm]ean|[Ss]td",features$V2, value=TRUE)
  feature_index <- grep("[Mm]ean|[Ss]td", features$V2)
  data_train_test <- select(data_train_test, feature_index)

##appropriately labels the data set with descriptive variable names. 
  setnames(data_train_test,feature_names)

##uses descriptive activity names to name the activities in the data set
  subject <- rbind(subject_train,subject_test)

##create activity label for train and test set 
  activity <- rbind(activity_train, activity_test)

##add subject_identifier and activity label to combined train/test data set
  data_tidy <- cbind(subject, activity, data_train_test)
  colnames(data_tidy)[1] <- "Subject_ID"
  colnames(data_tidy)[2] <- "Activity"

##rename activtiy-labels 1 to 6 by WALKING, WALKING_UPSTAIRS, ...
  activity_labels <- activity_labels$V2

    for(i in 1:6){
      data_tidy$Activity <- gsub(as.character(i), activity_labels[i], data_tidy$Activity)
    } 

##calculate average of each variable for each activity and each subject.
  data_mean <-aggregate(data_tidy, by=list(data_tidy$Activity, data_tidy$Subject_ID), FUN=mean)

##tidy data set erase redundant third and fourth column after aggregate function was applied
  data_mean_tidy <- select(data_mean, -c(3,4))
  colnames(data_mean_tidy)[colnames(data_mean_tidy) == "Group.1"] <- "Activity"
  colnames(data_mean_tidy)[colnames(data_mean_tidy) == "Group.2"] <- "Subject_ID"

##give out aggregated tidy data set as txt-file
  write.table(data_mean_tidy, "data_mean_tidy.txt", row.names = FALSE)
