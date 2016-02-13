## INTRODUCTION

The script "run_analysis.R" has been created as per requirement for the course assignment "Getting and Cleaning Data".

Training and test sets have been consolidated into a single data set.

The single data set is prepared by using the rbind() function that is applied to similar kind of data set.

It extracts only the measurements on the mean and standard deviation for each measurement.

features.txt contains column name and grep function is used to create indices for column named like mean or std

Uses descriptive activity names to name the activities in the data set.

This is done by taking activity name and IDs from activity_labesl.txt

Appropriately labels the data set with descriptive variable names. For descriptive label column name are replaced as follows

prefix t is replaced by time
Acc is replaced by Accelerometer
Gyro is replaced by Gyroscope
prefix f is replaced by frequency
Mag is replaced by Magnitude
BodyBody is replaced by Body
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

A single data set is creating merging X_data, y_data and and subject_data set after performing all above analysis. Then an independent tidy data set named avg_tidy_data is created with the average of each variable for each activity and each subject. ddply is used from plyr package.

VARIABLES

X_train, y_train, X_test, y_test, subject_train and subject_test contain the data loaded from given linked the downloadable files.

X_data, y_data and subject_data are merged for further analysis.

features loaded from feature.txt contains the correct names for the X_data dataset, from this mean_n_std_features, a numeric vector is created to to extract the desired data having mean() like and std() like as column name.

A similar approach is taken with activity names through the activity_labels variable. Descriptive and meaningful name is provied using gsub function

single_data contains the merging of X_data, y_data and subject_data in a single dataset.

avg_tidy_data contains the relevant averages which are then written into text file named avg_tidy_data.txt file. avg_tidy_data contains 180 rows (30 subjects * 6 activities) which is average for each subjects and activity type