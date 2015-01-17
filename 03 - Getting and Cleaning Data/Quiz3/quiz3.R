first <- function() {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile="idaho_housing.csv")
  data <- read.csv("idaho_housing.csv")
  
  ## households on greater than 10 acres who sold more than $10,000 worth of agriculture products
  agricultureLogical <- data$ACR == 3 & data$AGS == 6
  result <- which(agricultureLogical)[1:3]
  
  return(result)
}

second <- function() {
  library(jpeg)
  
  image <- readJPEG("getdata-jeff.jpg", native = TRUE)
  ## the 30th and 80th quantiles
  result <- quantile(image, probs = c(0.3, 0.8))
  
  return(result)
}

third <- function() {
  gdpUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  eduUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(gdpUrl, destfile="gdp.csv")
  download.file(eduUrl, destfile="edu.csv")
  
  gdp <- data.table(read.csv("gdp.csv", skip = 4, nrows = 215))
  edu <- data.table(read.csv("edu.csv"))
  
  setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rank", "Name", "gdp"))
  
  dt <- merge(gdp, edu, all = TRUE, by = c("CountryCode"))
  print(sum(!is.na(unique(dt$rank))))
  
  result <- dt[order(rank, decreasing = TRUE), list(CountryCode, Name, rank, gdp)][13]
  
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
  
  result <- dt[, mean(rank, na.rm = TRUE), by = Income.Group]
  
  return(result)
}

fifth <- function() {
  gdpUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  eduUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
  download.file(gdpUrl, destfile="gdp.csv")
  download.file(eduUrl, destfile="edu.csv")
  
  gdp <- data.table(read.csv("gdp.csv", skip = 4, nrows = 215))
  edu <- data.table(read.csv("edu.csv"))
  
  setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rank", "Name", "gdp"))
  
  dt <- merge(gdp, edu, all = TRUE, by = c("CountryCode"))
  
  ## convert gdp from factor to numeric
  tmp <- lapply(dt$gdp,function(x){as.numeric(gsub(",", "", x))})
  tmp <- as.numeric(tmp)
  dt$gdp <- tmp
  
  breaks <- quantile(tmp, probs = seq(0, 1, 0.2), na.rm = TRUE)
  dt$quantile <- cut(tmp, breaks = breaks)
  result <- dt[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantile")]
  
  return(result)
}