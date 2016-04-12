library(caret)
library(randomForest)
library(caret)

# this is a minimal working code for the submission
# for more details on the methods and for the analysis of the results, please see 
# the markup or HTML file called "writeup" in this repository

# also note that this algorithm will run aoutomatically when sourced
# it can take some time (even a minute or two) while it finishes

set.seed(6543)

# read data in
data <- read.csv("pml-training.csv")
test_data <- read.csv("pml-testing.csv")

# this function writes the passed argument to the disk as separate text files
# the result of the test prediction will be saved this way ie. problem_id_1.txt, etc
pml_write_files <- function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

# this function returns all the indices that should be removed from the data upon cleaning
getToRemoveIndices <- function() {
  toremove <- numeric()
  
  for(i in 1:length(data)) {
    # either too many NAs, too many #DIV/0s or too many empty values ("")
    if(sum(is.na(data[i])) > 0.2*nrow(data) || sum(data[i] == "#DIV/0!") > 0.2*nrow(data) || sum(data[i] == "") > 0.2*nrow(data) ) {
      # then don't include in cleaned
      toremove <- c(toremove, i)
    }
  }
  
  # also include the first three variables as they are not actual measurements
  toremove <- c(toremove, 1:7)
  return(toremove)
}

# save the indices returned by the function
toremove <- getToRemoveIndices()

# remove said indices
cleaned <- data[,-toremove]
test_data <- test_data[-toremove]

# create training (75%) and cross validation (25%) subsets
subsamples <- createDataPartition(y=cleaned$classe, p=0.75, list=FALSE)
trainingset <- cleaned[subsamples, ] 
crossvalidationset <- cleaned[-subsamples, ]

# random forest model creation
model <- randomForest(classe ~. , data=trainingset, method="class")
# predicion on the cross validation set to analyze our prediction
prediction <- predict(model, crossvalidationset[,-53], type = "class")

# performance of our predicion on the cross validation set
# see the writeup markup or HTML for more detail on this
confusionMatrix(prediction, crossvalidationset$classe)

# the final predictions, on the test set
testprediction <- predict(model, test_data, type="class")

# save files for submission
pml_write_files(testprediction)

