corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  filenames <- list.files(directory[1], pattern="*.csv", full.names=TRUE)
  complete = complete(directory)
  ids = complete[complete["nobs"]>threshold,]$id
  
  corr = numeric()
  
  for (i in ids) {
    file = read.csv(filenames[i])  
    removed <- na.omit(file)
    corr = c(corr, cor(removed$sulfate, removed$nitrate))
  }
  
  return(corr)
}