library(tidyverse)
###read in data
household_power_consumption <- read_delim("household_power_consumption.txt",";", escape_double = FALSE, trim_ws = TRUE)

###filter February dates and transform Date and Time variable classes 
feb_data=subset(household_power_consumption, Date%in%c("1/2/2007","2/2/2007"))%>%
  mutate(Date=as.Date(Date),
         Time=as.character(Time)%>%strptime(., format = "%H:%M:%S"))

###generate plot
png(file="plot1.png",width = 480, height = 480, units = "px") #Open png device; create 'plot1.png' 
hist(feb_data$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power") #Create plot
dev.off() #Close png device