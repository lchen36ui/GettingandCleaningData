# This readme file is for run_analysis.R which shows the following work

1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Note
 When extracting the UCI HAR Dataset, 
 1. under directory of train there are "subject_train.txt", "X_train.txt", and "y_train.txt"; the "X_train.txt" has been renamed as "x_train.txt" (lowercase x) for consistency.
 2. under directory of text there are "subject_test.txt", "X_test.txt", and "y_test.txt"; the "X_test.txt" has been renamed as "x_test.txt" (lowercase x) for consistency.
