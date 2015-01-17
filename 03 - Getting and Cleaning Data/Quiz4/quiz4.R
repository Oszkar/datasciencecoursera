first <- function() {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile="idaho_housing.csv")
  data <- read.csv("idaho_housing.csv")
  
  names <- names(data)
  split <- strsplit(names, "wgtp")
  result <- split[[123]]
  
  return(result)
}

second <- function() {
  library(data.table)
  
  gdpUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(gdpUrl, destfile="gdp.csv")
  data <- data.table(read.csv("gdp.csv", skip = 4, nrows = 215))
  
  ## convert gdp from factor to numeric
  gdp <- lapply(data[[5]],function(x){as.numeric(gsub(",", "", x))})
  gdp <- as.numeric(gdp)
  
  return(mean(gdp, na.rm=TRUE))
}

third <- function() {
  library(data.table)
  
  gdpUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(gdpUrl, destfile="gdp.csv")
  data <- data.table(read.csv("gdp.csv", skip = 4, nrows = 215))
  
  ## convert gdp from factor to numeric
  gdp <- lapply(data[[5]],function(x){as.numeric(gsub(",", "", x))})
  gdp <- as.numeric(gdp)
  
  result <- sum(grepl("^United", data[[4]]))
  
  return(result)
}

fourth <- function() {
  gdpUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  eduUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(gdpUrl, destfile="gdp.csv")
  download.file(eduUrl, destfile="edu.csv")
  
  gdp <- data.table(read.csv("gdp.csv", skip = 4, nrows = 215))
  edu <- data.table(read.csv("edu.csv"))
  
  setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rank", "Name", "gdp"))
  
  dt <- merge(gdp, edu, all = TRUE, by = c("CountryCode"))
  
  containsYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
  containsJune <- grepl("june", tolower(dt$Special.Notes))
  result <- length(dt[containsYearEnd & containsJune, Special.Notes])
  
  return(result)
}

fifth <- function() {
  library(quantmod)
  amzn = getSymbols("AMZN",auto.assign=FALSE)
  sampleTimes = index(amzn)
  
  year <- sum(year(sampleTimes) == 2012)
  mondays <- sum(weekdays(sampleTimes) == "hétfő" & year(sampleTimes) == 2012)
  
  return(list(year, mondays))
}