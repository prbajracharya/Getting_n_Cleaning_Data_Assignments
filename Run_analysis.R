##  Script as per requirement for the course assignment "Getting and Cleaning Data"

## Load library plyr

library(plyr)
library(dplyr)

###########################################################################
## Step 1 : Merges the training and test sets to create one data set.
###########################################################################

getwd() # "C:/Users/i80471/Documents/UCI HAR Dataset/"

## load data from each folder train and test

X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

## creating 'x','y' and 'subject_data' sets using rowbinding
X_data <- rbind(X_train, X_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# dim(X_data)        # [1] 10299   561
# dim(y_data)        # [1] 10299     1
# dim(subject_data)  # [1] 10299     1


##################################################################################################
## Step 2 : Extracts only the measurements on the mean and standard deviation for each measurement. 
##################################################################################################


features <- read.table("./features.txt")
# str(features)   # data.frame':	561 obs. of  2 variables:,$ V1: int  1 2 3 4 5 6 7 8 9 10 and $ V2: Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244

## selecting only columns with mean() or std() in their names from features data.frame
mean_n_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
# length(mean_n_std_features)  #[1] 66

## subset the desired columns in X_data from 561 column to 66 column
X_data <- X_data[, mean_n_std_features]
# dim(X_data)        # [1] 10299   66
# str(X_data)

## label the corrected column name in X_data from features 
names(X_data) <- features[mean_n_std_features, 2]


###########################################################################
## Step 3 : Uses descriptive activity names to name the activities in the data set. 
###########################################################################

activity_labels <- read.table("./activity_labels.txt")
# dim(activity_labels)     #[1] 6 2

## update values in y_data set by description from activity_labels
y_data[, 1] <- activity_labels[y_data[, 1], 2]

## label the column name "activity" in y_data set and "subject" in subject_data
names(y_data) <- "activity"

names(subject_data) <- "subject"


###########################################################################
## Step 4 : Appropriately labels the data set with descriptive variable names. 
###########################################################################

## assigning labels with descriptive information

names(X_data)<-gsub("^t", "time", names(X_data))
names(X_data)<-gsub("^f", "frequency", names(X_data))
names(X_data)<-gsub("Acc", "Accelerometer", names(X_data))
names(X_data)<-gsub("Gyro", "Gyroscope", names(X_data))
names(X_data)<-gsub("Mag", "Magnitude", names(X_data))
names(X_data)<-gsub("BodyBody", "Body", names(X_data))


###########################################################################
## Step-5 : From the data set in step 4, creates a second, independent tidy data set with 
##          the average of each variable for each activity and each subject.
###########################################################################

##  creating single data set from all 3 data set

single_data <- cbind(X_data, y_data, subject_data)
# dim(single_data)    #[1] 10299    68  (last 2 columns are activity and subjcet)

avg_tidy_data <- ddply(single_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(avg_tidy_data, "./avg_tidy_data.txt", row.name=FALSE)
# dim(avg_tidy_data)    [1] 180  68