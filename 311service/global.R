library(shiny)
library(leaflet)
library(dplyr)
library(shinydashboard)
library(DT)
library(lubridate)
library(data.table)
library(googleVis)

setwd("C:/nydsa bootcamp slides/Projects/2/Shinyapp/311service")
service_data <- read.csv(file = "./data_v3.csv")
#service_data <- read.csv(file = "./test.csv")


Borchoice <- unique(service_data$Borough)
service_data$Created.Date1<-as.Date(service_data$Created.Date,format="%m/%d/%Y")

