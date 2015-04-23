# Getting-and-Cleaning-Data-Project
Course Project for the Coursera Data Science Getting and Cleaning Data class-
Jen N.

The run_analysis.R file contains to script to obtain the tidy data set.  Briefly, raw train and test files were placed in the current working directory.  The data from each set were merged together.  Measurements were selected based on if they contained the string "mean" or "std" at the end of the variable name.  Variable names were chosen based on the features.txt document that was provided with the train and test data.  The appropiate variable names were extracted, and the resulting dataframe was reshaped into the tidy data set. A tidy_data.txt file was created.  

The tidy data is ordered by subject and activity.  Each column variable contains the mean of variable.  The descriptions of each variable are outlined in the codebook.

In order to read the tidy_data.txt data set into R, save the file to the working directory and use the following code:

data <- read.table("tidy_data.txt", header = TRUE) 
    View(data)
