run_analysis <- function() {
  
require(dplyr)
require(readr)
require(tidyr)
require(tidyselect)

setwd("~/Coursera/Data Cleaning/Week 4 Assignment")

dat <- read_data() #reads files into list

dat <- simp_x(dat) #extracts & labels columns from the X-* lists

dat <- label_cols(dat) #labels subject_* and y_* columns

dat <- label_activities(dat) #replaces y_* values with activity names

test <- cbind(dat$subject_test, dat$y_test, dat$X_test) #extracts test data
train <- cbind(dat$subject_train, dat$y_train, dat$X_train) #extracts train data

dat <- rbind(test, train) #puts train and test data in 1 data-frame

dat <- as.data.frame(dat) #coerces data to data.frame


#outputs a single data frame with only the means of the columnns by subject and actvity
dat %>% group_by(subject, activity) %>% summarise_if(is.numeric,mean)

}

#reads all pertinent files into a list
read_data <- function() {
  
  files <- list.files(pattern = "*\\.txt$", include.dir = TRUE, recursive = TRUE)
  files <- files[!grepl("Inertial Signals", files) & !grepl("README", files) & !grepl("features_info", files) & !grepl("results", files)]
  
  patterns <- list(".*/", "*\\.txt$")
  search <- paste(unlist(patterns), collapse = "|")
  
  list_labels <- gsub(search, "", files)
  
  dat <- lapply(files, function(x) read.table(x, stringsAsFactors = FALSE))
  
  names(dat) <- list_labels
  
  dat
  
}

#extracts only the variables that are measures of mean & sd from the X_* lists
simp_x <- function(dat) {
  cols <- subset(dat$features, grepl("mean()", V2, fixed = TRUE) | grepl("std()", V2, fixed = TRUE))
  select_cols <- paste("V", cols[,1], sep="")
  
  dat$X_test <- dat$X_test[,select_cols]
  dat$X_train <- dat$X_train[, select_cols]
  
  colnames(dat$X_test) <- cols[,2]
  colnames(dat$X_train) <- cols[,2]
  
  dat
}

#labels the subject_* and y_* lists
label_cols <- function(dat) {
  colnames(dat$activity_labels) <- c("label", "activity")
  colnames(dat$subject_train) <- "subject"
  colnames(dat$subject_test) <- "subject"
  colnames(dat$y_train) <- "activity"
  colnames(dat$y_test) <- "activity"
  
  dat
}

#replaces activity numbers with activity names in the y_* lists
label_activities <- function(dat) {
  dat$y_test$activity <- dat$activity_labels[match(dat$y_test$activity, dat$activity_labels$label),]$activity
  dat$y_train$activity <- dat$activity_labels[match(dat$y_train$activity, dat$activity_labels$label),]$activity
  
  dat
}
