library(tidyverse)
###read in data
household_power_consumption <- read_delim("household_power_consumption.txt",";", escape_double = FALSE, trim_ws = TRUE)

###filter February dates and transform Date and Time variable classes 
feb_data=subset(household_power_consumption, Date%in%c("1/2/2007","2/2/2007"))%>%
  mutate(Date=as.Date(Date),
         Time=as.character(Time)%>%strptime(., format = "%H:%M:%S"))

###generate plot
png(file="plot3.png",width = 480, height = 480, units = "px") #Open png device; create 'plot3.png' 

plot(feb_data$Sub_metering_1, 
     type="l", 
     ylab = "Energy sub metering",
     xlab = "",
     xaxt="n") #plot line chart with sub_metering_1 without x-axis labels and ticks

lines(feb_data$Sub_metering_2,
      col="red") #add red line with sub_metering_2

lines(feb_data$Sub_metering_3,
      col="blue") #add blue line with sub_metering_3

xtick<-seq(1,nrow(feb_data),length=3) #define position of ticks
axis(side=1, 
     at=xtick, 
     labels = FALSE) #draw ticks
text(x=xtick, 
     par("usr")[3],
     labels=c("Thu","Fri","Sat"),
     pos = 1, 
     xpd = TRUE) #add labels

legend("topright", 
       lty = 1, 
       col = c("black", "red" ,"blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")) #add legend

dev.off()
