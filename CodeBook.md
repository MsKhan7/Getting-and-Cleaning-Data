1.Download the dataset Dataset downloaded and extracted under the folder called UCI HAR Dataset

2.Assign each data to variables

features <-features.txt The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
data.x.train <-X_train.txt contains recorded features train data
data.y.train <-y_train.txt contains train data of activities'code labels
data.subject.train <-subject_train.txt contains train data of 21/30 volunteer subjects being observed
data.x.test <-X_test.txt contains recorded features test data
data.activity.test <-y_test.txt contains test data of activities'code labels
data.subject.test <-subject_test.txt contains test data of 9/30 volunteer test subjects being observed
3.Merges the training and the test sets to create one data set

data.train is created by merging data.x.train and data.y.train and data.subject.train
data.test is created by merging data.x.test and data.activity.test and data.subject.test
data.all is created by merging data.test data.train using rbind()
4.Extracts only the measurements on the mean and standard deviation for each measurement

data.sub is created by subsetting data.all, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

5.Uses descriptive activity names to name the activities in the data set

Entire numbers in code column of the data.sub replaced with corresponding activity taken from second column of the activities variable

6.Appropriately labels the data set with descriptive variable names

All Acc in column's name replaced by Accelerometer
All Gyro in column's name replaced by Gyroscope
All BodyBody in column's name replaced by Body
All Mag in column's name replaced by Magnitude
All tBody in column' name replaced by TimeBody
All -mean- in column' name replaced by Mean
All -std- in column' name replaced by StandardDeviation
All angle in column' name replaced by Angle
All gravity in column' name replaced by Gravity
All start with character f in column's name replaced by Frequency
All start with character t in column's name replaced by Time
7.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

data_tidy is created by sumarizing data.sub taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export data.tidy into data_tidy.txt file.
