# Get daily data from https://www.health.pa.gov/topics/disease/coronavirus/Pages/Cases.aspx
# Daily updates are posted at 12pm
# This script will run daily at 12:05pm


# load necessary packages
packages <- c("rvest", "tidyverse", "data.table")
missing.packages <- setdiff(packages,installed.packages()[,"Package"])
if(length(missing.packages)) install.packages(missing.packages)
for(pkg in packages) {
  do.call("library",list(pkg))
}

# get today's date
today <- Sys.Date()
yesterday <- today - 1

# read in data from webpage
url <- "https://www.health.pa.gov/topics/disease/coronavirus/Pages/Cases.aspx"
webpage <- xml2::read_html(url)

# get date from first <em> node
# get all emnodes
emnodes <- webpage %>% html_nodes("em")
# select first emnode and extract text
datetext <- emnodes[[1]] %>% html_text()
# extract the date from the text
statsdate <- as.Date( gsub( ".*(\\d{1,2}/\\d{1,2}/\\d{4}).*", "\\1", datetext) , format="%m/%d/%Y")


# check if data has been updated
if (statsdate == today) {
  # get total cases table (first table on the page)
  totalcases <- rvest::html_table(webpage, header = TRUE)[[1]] 
  # assign appropriate table names
  names(totalcases) <- c("Total_Cases","Deaths","Negative")
  # Function to replace thousands commas with empty value
  replaceCommas<-function(x){
    x<-as.numeric(gsub("\\,", "", x))
  }
  
  # apply replaceCommas to the dataframe and assign back to the dataframe as a dataframe
  totalcases<- as.data.frame(lapply(totalcases, replaceCommas))
  # add a date column
  totalcases$Date <- statsdate
  totalcases
  
  # get county case data
  countycases <- rvest::html_table(webpage, header = TRUE)[[4]]
  # add a date column
  countycases$Date <- statsdate
  names(countycases) <- c("County","Total_Cases", "Negatives","Deaths","Date")
  # reorder columns to make Date first to match previous CSV file
  countycases <- countycases %>% select(Date, everything())
  glimpse(countycases)
  
  # get nursing home data
  nursinghomes <- rvest::html_table(webpage, header = TRUE)[[8]]
  glimpse(nursinghomes)

  # remove last row which is total for all of PA
  nursinghomes <- nursinghomes[-nrow(nursinghomes),]
  # add a date column
  nursinghomes$Date <- statsdate
  names(nursinghomes) <- c("County","NumFacilities","Cases_Residents","Cases_Employees","Deaths","Date")
  # convert County names to Sentence case
  nursinghomes$County <- str_to_sentence(nursinghomes$County, locale = "en")
  # instead of a 0 for no cases, a . is appearing in Cases_Employees
  nursinghomes <- nursinghomes %>% 
    mutate(Cases_Employees = replace(Cases_Employees, Cases_Employees == '.', "0"))
  # reorder columns to match previous CSV file
  nursinghomes <- nursinghomes %>% select(Date, everything())
  # convert Cases_Employees to numeric
  nursinghomes$Cases_Employees <- as.numeric(nursinghomes$Cases_Employees)
  # create Total Cases column
  nursinghomes <- nursinghomes %>% mutate(NH_TotalCases = Cases_Residents + Cases_Employees)
  glimpse(nursinghomes)
  
  # write to csv
  write_csv(totalcases, paste0("data/",statsdate,"_totalcases.csv"),col_names=TRUE)
  write_csv(countycases, paste0("data/",statsdate,"_countycases.csv"),col_names=TRUE)
  write_csv(nursinghomes, paste0("data/",statsdate,"_nursinghomes.csv"),col_names=TRUE)
  
  # read in county data from yesterday
  data <- read_csv(paste0("data/PACountyCovid19_",yesterday,".csv"))
  
  # convert Date to datetime format for original dataframe
  #data$Date <- mdy(data$Date)
  
  # combine new data with previous data
  countydata <- rbind(data,countycases)
  
  # write to new csv file
  write_csv(countydata, paste0("data/PACountyCovid19_",today,".csv"), col_names = TRUE)
  
  # read in Nursing Home Data from yesterday
  nh <- read_csv(paste0("data/NursingHomes_",yesterday,".csv"))
  
  # convert Date to datetime format for original dataframe
  #nh$Date <- mdy(nh$Date)
  
  # combine new data with previous data
  nh_data <- rbind(nh,nursinghomes)
  
  # write to new csv file
  write_csv(nh_data, paste0("data/NursingHomes_",today,".csv"), col_names = TRUE)
  
} else{
  print("Website has not yet been updated today.")
}





