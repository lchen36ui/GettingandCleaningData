 ## Create one R script called run_analysis.R that does the following: 
 ## 1. Merges the training and the test sets to create one data set.
 ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 ## 3. Uses descriptive activity names to name the activities in the data set.
 ## 4. Appropriately labels the data set with descriptive activity names.
 ## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. ##
 
 ## Under working directory, load and process x_test & y_test data ##
 	x_test <- read.table("./UCI HAR Dataset/test/x_test.txt", header = FALSE) 
 	y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE) 
 	subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE) 
 
 ## Under working directory, load x_train & y_train & subject_train data ##
 	x_training <- read.table("./UCI HAR Dataset/train/x_train.txt", header = FALSE) 
 	y_training <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE) 
 	subject_training <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE) 

 ## Under working directory, load activity labels, and features data column names ##
 	
	activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2] 
	features <- read.table("./UCI HAR Dataset/features.txt")[,2] 
 
 ## From features, extract only the measurements on the mean and standard deviation for each measurement ##
 	ext_features <- grepl("mean|std", features) 

 ## Process test data, and extract the required measurements on the mean and strandard deviation ##
 	names(x_test) = features 
  	x_test = x_test[,ext_features] 
 
     ## Activity labels (IDs, Labels) ##
 	y_test[,2] = activity_labels[y_test[,1]] 
 	names(y_test) = c("Activity_ID", "Activity_Label") 
 	names(subject_test) = "Subject" 
 
     ## Combine test data ##
 	test_data <- cbind(as.data.table(subject_test), y_test, x_test) 
 
 ## Process training data, and extract the required measurements on the mean and strandard deviation ##
 	names(x_training) = features 
  	x_training = x_training[,ext_features] 
 
     ## Activity labels (IDs, Labels) ##
 	y_training[,2] = activity_labels[y_training[,1]] 
 	names(y_training) = c("Activity_ID", "Activity_Label") 
 	names(subject_training) = "Subject" 
 
     ## Combine training data ##
 	training_data <- cbind(as.data.table(subject_training), y_training, x_training) 
 
 ##  Merge test and training data ##
 	 mdata = rbind(test_data, training_data) 

 ##  Lables the data set ##
 	 id_labels   = c("Subject", "Activity_ID", "Activity_Label") 
 	 data_labels = setdiff(colnames(mdata), id_labels) 
 	 melt_data   = melt(mdata, id = id_labels, measure.vars = data_labels) 
 
 ##  creates a second, independent tidy data set with the average of each variable for each activity and each subject 
 ##  to dataset using dcast function ##  
 	 tidy_data = dcast(melt_data, Subject + Activity_Label ~ variable, mean) 
 
 ## Generated tidy_data.txt ##
  	write.table(tidy_data, file = "./tidy_data.txt",row.name=FALSE)
