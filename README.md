Getting-and-Cleaning-data
=========================

This repository was created to include the files relevant to the final project for the Getting and Cleaning Data course on coursera 

This is a readme file which describes the run_analysis.R script written as part of course project for Getting and Cleaning Data on Coursera.

The run_analysis.R script achieves the following tasks
	1. Install and load the required R packages
		a. For the purpose of this project, we will need to install and load the reshape2 and stats package

	2. Download the raw data from the source and unzip the files
		a. Set the working directory to the location where you want the files to reside using the setwd() command
		b. Download the file from the given URL as a zip
		c. Use the unzip command to unzip the files to the working directory
	
	3. Concatenate all test files
		a. Load the subject_test, X_test, and y_test into individual dataframes using read.table
		b. Load the features file containing the name of columns for X_test into a dataframe
		c. Assign names from features dataframe to xtestdf (X_test)  by converting features to character vector
		d. Using grepl, create a logical vector to extract the MEAN and SD related columns from xtest dataframe
		e. Using the logical vector from the above step, retain only the MEAN and SD columns from xtest dataframe through subsetting
		f. Using cbind, concatenate the subject_test, X_test, and y_test files to create the test dataframe
		g. This data frame will contain the subject id and related MEAN and SD values for test subjects
		
	4. Concatenate all the train files
		a. Load the subject_train, X_train, and y_train into individual dataframes using read.table
		b. Using the features dataframe created for test files, assign names from features dataframe to xtraindf (X_train)  by converting features to character vector
		c. Using grepl, create a logical vector to extract the MEAN and SD related columns from xtrain dataframe
		d. Using the logical vector from the above step, retain only the MEAN and SD columns from xtrain dataframe through subsetting
		e. Using cbind, concatenate the subject_train, X_train, and y_train files to create the train dataframe
		f. This data frame will contain the subject id and related MEAN and SD values for train subjects
	
	5. Combine the test and train data
		a. Merge the test and train dataframes using the rbind function since rbind binds data across the rows. The test and train data contain the same columns but will have the same observations for multiple subjects.
	
	6. Merge the activityid with the combineddata basd on activity id and retain the activity names
		a. Load the activity_lables file into a dataframe
		b. Rename the two columns as activityid and activityname
		c. Merge the activitylabels with the combineddata from step#5 based on activity id
		d. The updated merged data will contain the subject id, activity, activity name, and associated MEAN and SD
		
	7. Rename the variables by replacing "-" to "."
		a. Create a function using gsub to replace "-" with "."
		b. Apply the function to all the columns on the merged data using sapply
		c. Associated with the original readme file of the data, the resulting names are descriptive enough for a reader to understand each variable and its value
		d. Remove the activity id since the activity name refers to the same thing but is much more descriptive
	
	8. Summarize the data to arrive at a tidy data set
		a. The data set at the end of step#7 will contain 10,699 rows and 68 columns (33 Mean, 33 SD,1 Activity Name and 1 Subject ID)
		b. Using the aggregate function extract the MEAN and SD for each combination of subject id and activity name
		c. There are 30 subjects and 6 activities. Hence the tidy data will contain 30*6=180 rows and 68 columns
		d. This is the final tidy data set that is uploaded to github
	
	9. Remove the temporary dataframes from the environment to free up the memory
