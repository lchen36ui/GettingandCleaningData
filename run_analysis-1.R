 ## Create one R script called run_analysis.R that does the following: ##
 ## 1. Merges the training and the test sets to create one data set. ##
 ## 2. Extracts only the measurements on the mean and standard deviation for each measurement. ##
 ## 3. Uses descriptive activity names to name the activities in the data set ##
 ## 4. Appropriately labels the data set with descriptive activity names. ##
 ## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. ##
 
  
 
 ## Under working directory, load activity labels, and features data column names ##
 	activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2] 
 
	features <- read.table("./UCI HAR Dataset/features.txt")[,2] 
 
 
 ## Extract only the measurements on the mean and standard deviation for each measurement. 
 	extract_features <- grepl("mean|std", features) 
 
 
 ## Under working directory, load and process x_test & y_test data. 
 	x_test <- read.table("./UCI HAR Dataset/test/x_test.txt") 
 	y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
 	subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") 
 
 
 	names(x_test) = features 
 
 
 ## Extract only the measurements on the mean and standard deviation for each measurement. 
 	x_test = x_test[,extract_features] 
 
 
 ## Load activity labels 
 	y_test[,2] = activity_labels[y_test[,1]] 
 	names(y_test) = c("Activity_ID", "Activity_Label") 
 	names(subject_test) = "subject" 
 
 
 ## Bind data 
 	test_data <- cbind(as.data.table(subject_test), y_test, x_test) 
 
 
 ## Under working directory, load and process x_train & y_train data. 
 	x_train <- read.table("./UCI HAR Dataset/train/x_train.txt") 
 	y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") 
 
 
 	subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") 
 
 
 	names(x_train) = features 
 
 
 ## Extract only the measurements on the mean and standard deviation for each measurement. 
 	x_train = x_train[,extract_features] 
 
 
 ## Load activity data 
 	y_train[,2] = activity_labels[y_train[,1]] 
 	names(y_train) = c("Activity_ID", "Activity_Label") 
 	names(subject_train) = "subject" 
 
 
 ## Bind data 
 	train_data <- cbind(as.data.table(subject_train), y_train, x_train) 
 
 
 ##  Merge test and train data ##
 	 mdata = rbind(test_data, train_data) 
 
 ##  Lables the data set with 
 	 id_labels   = c("Subject", "Activity_ID", "Activity_Label") 
 	 data_labels = setdiff(colnames(mdata), id_labels) 
 	 melt_data      = melt(mdata, id = id_labels, measure.vars = data_labels) 
 
 ##  creates a second, independent tidy data set with the average of each variable for each activity and each subject 
 ## 	 to dataset using dcast function ##  
 	 tidy_data   = dcast(melt_data, Subject + Activity_Label ~ variable, mean) 
 
 ## Generated tidy_data.txt ##
  	write.table(tidy_data, file = "./tidy_data.txt") 
