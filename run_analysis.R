library(data.table)
#downloading the file
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}

#converting it to single data frame
features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

data.x.train<-read.table('./UCI HAR Dataset/train/X_train.txt')
data.y.train<- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data.subject.train <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')
data.train <-  data.frame(data.subject.train, data.y.train, data.x.train)
names(data.train) <- c(c('subject', 'activity'), features)

data.x.test <- read.table('./UCI HAR Dataset/test/X_test.txt')
data.activity.test <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data.subject.test <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

data.test <-  data.frame(data.subject.test, data.activity.test, data.x.test)
names(data.test) <- c(c('subject', 'activity'), features)

#1.Merges the training and the test sets to create one data set.
data.all <- rbind(data.train, data.test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std.select <- grep('mean|std', features)
data.sub <- data.all[,c(1,2,mean_std.select + 2)]

#3.Uses descriptive activity names to name the activities in the data set
activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity.labels <- as.character(activity.labels[,2])
data.sub$activity <- activity.labels[data.sub$activity]

#4.Appropriately labels the data set with descriptive variable names.
name.new <- names(data.sub)
name.new <- gsub("[(][)]", "", name.new)
name.new <-gsub("BodyBody","Body",name.new)
name.new <- gsub("^t", "Time", name.new)
name.new <- gsub("^f", "Frequency", name.new)
name.new <-gsub("tBody","TimeBody",name.new)
name.new <-gsub("angle","Angle",name.new)
name.new <-gsub("gravity","Gravity",name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "Mean", name.new)
name.new <- gsub("-std-", "StandardDeviation", name.new)
name.new <- gsub("-", "_", name.new)
names(data.sub) <- name.new

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

data.tidy <- aggregate(data.sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)
