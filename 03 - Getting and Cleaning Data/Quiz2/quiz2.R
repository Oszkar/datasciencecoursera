first <- function() {
  library(httr)
  library(jsonlite)
  library(rjson)
  
  # 1. Find OAuth settings for github:
  #    http://developer.github.com/v3/oauth/
  oauth_endpoints("github")
  
  # 2. Register an application at https://github.com/settings/applications;
  #    Use any URL you would like for the homepage URL (http://github.com is fine)
  #    and http://localhost:1410 as the callback url
  #
  #    Insert your client ID and secret below - if secret is omitted, it will
  #    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
  myapp <- oauth_app("github", "18301b06cb4f783da859", "64f2308216e19eeeca24fe1fb8b75dc080e56a95")
  
  # 3. Get OAuth credentials
  github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
  
  # 4. Use API
  gtoken <- config(token = github_token)
  req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
  stop_for_status(req)
  
  data <-  fromJSON(toJSON(content(req)))
  
  for(item in a) {
    if(item$name == "datasharing") {
      result <- item$created_at
    }
  }
  
  return(result)
}

second <- function() {
  library(sqldf)
  
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  download.file(fileUrl,destfile="acs.csv")

  acs <- read.csv("acs.csv")
  
  return(sqldf("select pwgtp1 from acs where AGEP < 50"))
  
}

third <- function() {
  ## no code
}

fourth <- function() {
  con = url("http://biostat.jhsph.edu/~jleek/contact.html")
  htmlCode = readLines(con)
  close(con)
  
  result <- numeric()
  
  result <- c(result, nchar(htmlCode[10]))
  result <- c(result, nchar(htmlCode[20]))
  result <- c(result, nchar(htmlCode[30]))
  result <- c(result, nchar(htmlCode[100]))
  
  return(result)
}

fifth <- function() {
  x <- read.fwf(
    file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
    skip=5,
    widths=c(12, 7,4, 9,4, 9,4, 9,4))
  
  return(sum(x[,4]))
}