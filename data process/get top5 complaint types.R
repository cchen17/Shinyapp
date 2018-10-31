library(dplyr)
library(stringr)
library(lubridate)
setwd("C:/nydsa bootcamp slides/Projects/2/Shinyapp/data process")
service_data <- read.csv(file = "./2018_halfyear.csv")

service_data<-service_data%>%
  mutate(Complaint.Type=gsub('Noise - Residential','Noise',Complaint.Type,fixed=TRUE))%>%
#  mutate(Complaint.Type=gsub('Noise - Street/Sidewalk','Noise',Complaint.Type,fixed=TRUE))%>%
#  mutate(Complaint.Type=gsub('Noise - Commercial','Noise',Complaint.Type,fixed=TRUE))%>%
  mutate(Complaint.Type=gsub('HEAT/HOT WATER','Water System',Complaint.Type,fixed=TRUE))%>%
  mutate(Complaint.Type=gsub('Blocked Driveway','Illegal Parking',Complaint.Type,fixed=TRUE))%>%
  # mutate(Complaint.Type=gsub('WATER LEAK','Water System',Complaint.Type,fixed=TRUE))%>%
   mutate(Complaint.Type=gsub('Street Light Condition','Street Condition',Complaint.Type,fixed=TRUE))
  # mutate(Complaint.Type=gsub('Noise - Vehicle','Noise',Complaint.Type,fixed=TRUE))%>%
  # mutate(Complaint.Type=gsub('Derelict Vehicles','Derelict Vehicle',Complaint.Type,fixed=TRUE))%>%
  # mutate(Complaint.Type=gsub('PAINT/PLASTER','Graffiti',Complaint.Type,fixed=TRUE))%>%
  # mutate(Complaint.Type=gsub('PLUMBING','Plumbing',Complaint.Type,fixed=TRUE))%>%
  # mutate(Complaint.Type=gsub('UNSANITARY CONDITION','Unsanitary Condition',Complaint.Type,fixed=TRUE))%>%
  # mutate(Complaint.Type=gsub('DOOR/WINDOW','Door/Window',Complaint.Type,fixed=TRUE))
  
  

aaa<-service_data%>%group_by(Complaint.Type)%>%
  summarise(n=n())%>%
  arrange(desc(n))

#aaa[grep("UNSANITARY*",aaa$Complaint.Type),]
sum(head(aaa,5)$n)
aaa<-head(aaa,5)
final_df<-semi_join(service_data,aaa,by="Complaint.Type")
#final_df$Created.Date<-as.Date(final_df$Created.Date,format="%m/%d/%Y")


bbb<-head(final_df,135932)
bbb<-bbb%>%filter(!is.na(Longitude))

write.csv(bbb,"data_v3.csv")
