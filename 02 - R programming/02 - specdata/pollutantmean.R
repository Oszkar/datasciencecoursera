pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  filenames <- list.files(directory[1], pattern="*.csv", full.names=TRUE)
  filenames <- filenames[id]
  
  means = numeric()
  
  for (i in 1:length(id)) {
    file = read.csv(filenames[i])
    means = c(means, file[[pollutant]])
  }
  
  return(mean(means, na.rm = TRUE))
}