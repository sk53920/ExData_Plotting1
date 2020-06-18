library(dplyr)
library(lubridate)

#This script will create output a line plot of Sub metering 1-3 against timestamp to working directory.


#Read file located in working directory

fulltbl <- fread("household_power_consumption.txt", sep=";")

#Filter data table to relevant date range (2007-02-01 to 2007-02-02) and convert data columns to numeric
df <- fulltbl %>% mutate(Date=dmy(Date)) %>% filter(Date>="2007-02-01" & Date <="2007-02-02")
df[,3:9] <- lapply(df[,3:9], as.numeric)

#Create a timestamp column that merges Date and Time columns together
dfdt <- df %>% mutate(Timestamp = ymd_hms(paste(Date," ", Time)))


#Create line plot of Sub metering 1-3 against timestamp
png("plot3.png", width=480, height=480, units="px")
plot(dfdt$Timestamp, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(dfdt$Timestamp, df$Sub_metering_2, type="l", col = "red")
points(dfdt$Timestamp, df$Sub_metering_3, type="l", col = "blue")
legend(x="topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lwd=2)
dev.off()

