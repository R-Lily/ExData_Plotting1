library(tidyverse)
###read in data
household_power_consumption <- read_delim("household_power_consumption.txt",";", escape_double = FALSE, trim_ws = TRUE)

###filter February dates and transform Date and Time variable classes 
feb_data=subset(household_power_consumption, Date%in%c("1/2/2007","2/2/2007"))%>%
  mutate(Date=as.Date(Date),
         Time=as.character(Time)%>%strptime(., format = "%H:%M:%S"))

xtick<-seq(1,nrow(feb_data),length=3) #define position of ticks

###generate plot
png(file="plot4.png",width = 480, height = 480, units = "px") #Open png device; create 'plot4.png' 

par(mfrow = c(2,2))
with(feb_data, {
  ###first plot
  plot(Global_active_power, 
       type="l", 
       ylab = "Global Active Power (kilowatts)",
       xlab = "",
       xaxt="n") #plot line chart without x-axis labels and ticks
  axis(side=1, 
       at=xtick, 
       labels = FALSE) #draw ticks
  text(x=xtick, 
       par("usr")[3],
       labels=c("Thu","Fri","Sat"),
       pos = 1, 
       xpd = TRUE) #add labels
  
  ###second plot
  plot(Voltage, 
       type="l", 
       ylab = "Voltage",
       xlab = "datetime",
       xaxt="n") #plot line chart without x-axis labels and ticks
  axis(side=1, 
       at=xtick, 
       labels = FALSE) #draw ticks
  text(x=xtick, 
       par("usr")[3],
       labels=c("Thu","Fri","Sat"),
       pos = 1, 
       xpd = TRUE) #add labels
  
  ###third plot
  plot(feb_data$Sub_metering_1, 
       type="l", 
       ylab = "Energy sub metering",
       xlab = "",
       xaxt="n") #plot line chart with sub_metering_1 without x-axis labels and ticks
  lines(Sub_metering_2,
        col="red") #add red line with sub_metering_2
  lines(Sub_metering_3,
        col="blue") #add blue line with sub_metering_3
  axis(side=1, 
       at=xtick, 
       labels = FALSE) #draw ticks
  text(x=xtick, 
       par("usr")[3],
       labels=c("Thu","Fri","Sat"),
       pos = 1, 
       xpd = TRUE) #add labels
  legend("topright", 
         bty = "n", 
         lty = 1, 
         col = c("black", "red" ,"blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")) #add legend
  ####fourth plot
  plot(Global_reactive_power, 
       type="l", 
       xlab = "datetime",
       xaxt="n") #plot line chart without x-axis labels and ticks
  axis(side=1, 
       at=xtick, 
       labels = FALSE) #draw ticks
  text(x=xtick, 
       par("usr")[3],
       labels=c("Thu","Fri","Sat"),
       pos = 1, 
       xpd = TRUE) #add labels
})

dev.off()
