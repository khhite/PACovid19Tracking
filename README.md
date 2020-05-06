# PACovid19Tracking
This is a look at Covid-19 cases in Pennsylvania from data provided by the PA Department of Health.  

The PA Department of Health provides updated Covid-19 data daily around 12pm. The GetDailyData.R file will scrape the updated data from https://www.health.pa.gov/topics/disease/coronavirus/Pages/Cases.aspx and save that data as separate csv files (one for total cases, one for nursing home data and one for county data). It will then read in the data from the previous day and combine the latest data to create new daily csv files.  

You PADashboard.Rmd is a Flexdashboard for state and county data. To run:  
**rmarkdown::run("PADashboard.Rmd")**


Data from PA Dept of Health :
https://www.health.pa.gov/topics/disease/coronavirus/Pages/Cases.aspx
https://www.health.pa.gov/topics/disease/coronavirus/Pages/Archives.aspx
