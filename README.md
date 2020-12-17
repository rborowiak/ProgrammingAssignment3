### ProgrammingAssignment3
Getting and Cleaning Data Course Project

### How does the analysis run.analysis.R works
- All pre-processed data sets (X_train, y_train, X_test, y_test), the subject-identifiers (subject_train, subject_test), 
  activity-identifiers (activity_labels) and 561 feature variables (features) are loaded as txt-files from "UCI HAR Dataset" using read.table 
- train and test data sets are merged using rbind
- measurements concerning mean and standard deviation are extracted using: grep("[Mn]ean|[Ss]td",..)
- subject-identifiers (1 to 30) and activity labels (1 to 6) are merged with the combined train and test sets
- activity labels are renamed by the labels given by activity_labels.txt (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
  using the gsub function
- The mean or average for each activity(WALKING, WALKING_UPSTAIRS, ..) and for each subject 1 to 30
  is calculated using: aggregate(data_tidy, by=list(data_tidy$Activity, data_tidy$Subject_ID), FUN=mean) resulting in a tidy data set with 180 x 88 elements
- Finally the tidy data set "data_mean_tidy" is given out using the write.table function 
