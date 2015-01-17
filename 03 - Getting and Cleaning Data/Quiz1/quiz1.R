first <- function() {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl,destfile="homes.csv")
  
  data <- read.csv("homes.csv")
  
  return(sum(data$VAL == 24, na.rm=TRUE))
}

second <- function() {
  ## no code
}

third <- function() {
  library(xlsx)
  
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
  download.file(fileUrl,destfile="natural_gas.xlsx",mode="wb")
  
  colIndex <- 7:15
  rowIndex <- 18:23
  dat <- read.xlsx("natural_gas.xlsx",sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
  
  return(sum(dat$Zip*dat$Ext,na.rm=T))
}

fourth <- function() {
  library(XML)
  
  fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
  doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
  rootNode <- xmlRoot(doc)
  
  d <- sum(xpathSApply(rootNode,"//zipcode",xmlValue) == "21231")
  
  return(d)
}

fifth <- function() {
  library(data.table)
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  download.file(fileUrl,destfile="communities.csv")
  
  DT <- data.table(read.table("communities.csv", header=TRUE, sep=","))
  
  return(DT[,mean(pwgtp15),by=SEX])
}