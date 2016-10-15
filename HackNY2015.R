#By: Glenda Ascencio                                                             HackNY 2015
############################################################################################
### Libraries
library(dplyr)
library(ggplot2)

### Setting the work directory
setwd("C:/Users/gascenciostudent/Desktop/HackNY")
data_dir <- "."

### Reading the collisions dataset
yellow_taxis <- data.frame(read.csv("C:/Users/gascenciostudent/Desktop/yellow_tripdata_2015-01-06.csv",
                                    nrows=1000000),
                                    stringsAsFactors = F, 
                                    sep=',', 
                                    header=F)

###########################################################################################
##                                      Data Cleaning                                    ##
###########################################################################################
### Extracting the columns we need
taxis <- yellow_taxis[ ,c(6, 7, 10, 11, 13, 14, 15, 17)]

### Checking if there's bad data in our dataframe
is.na(yellow_taxis$pickup_latitude && yellow_taxis$pickup_longitude && yellow_taxis$dropoff_longitude && yellow_taxis$pickup_latitude) #False = good ;)
is.na(yellow_taxis$pickup_latitude || yellow_taxis$pickup_longitude || yellow_taxis$dropoff_longitude || yellow_taxis$pickup_latitude) #False = good ;)

### Save the file
save(taxis, file="taxi.RData")

### Converting a .RData file into a csv file
resave <- function(file){
  e <- new.env(parent = emptyenv())
  load(file, envir = e)
  objs <- ls(envir = e, all.names = TRUE)
  for(obj in objs) {
    .x <- get(obj, envir =e)
    message(sprintf('Saving %s as %s.csv', obj,obj) )
    write.csv(.x, file = paste0(obj, '.csv'))
  }
}

### Saving the data frame
resave('taxi.RData')
