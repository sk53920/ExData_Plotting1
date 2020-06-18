library(dplyr)
library(lubridate)

#This script will create exploratory plots  of the UCI Electric Power Consumption data set and output 4 png plot files into the working directory

#Read file located in working directory

fulltbl <- fread("household_power_consumption.txt", sep=";")

#Filter data table to relevant date range (2007-02-01 to 2007-02-02) and convert data columns to numeric
df <- fulltbl %>% mutate(Date=dmy(Date)) %>% filter(Date>="2007-02-01" & Date <="2007-02-02")
df[,3:9] <- lapply(df[,3:9], as.numeric)

#Create histogram of global active power 
png("plot1.png", width=480, height=480, units="px")
hist(df$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

#For remaining plots, need to create a timestamp column that merges Date and Time columns together
dfdt <- df %>% mutate(Timestamp = ymd_hms(paste(Date," ", Time)))

#Create line plot of Global Active Power against timestamp
png("plot2.png", width=480, height=480, units="px")
plot(dfdt$Timestamp, dfdt$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="l")
dev.off()


#Create line plot of Sub metering 1-3 against timestamp
png("plot3.png", width=480, height=480, units="px")
plot(dfdt$Timestamp, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(dfdt$Timestamp, df$Sub_metering_2, type="l", col = "red")
points(dfdt$Timestamp, df$Sub_metering_3, type="l", col = "blue")
legend(x="topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lwd=2)
dev.off()

#Create 4x4 grid of plots of the following factors against timestamp: Global Active Power (Upper Left), Energy Sub Metering (Lower Left), Voltage (Upper Right), and Global Reactive Power (Lower Right)

png("plot4.png")
#Create grid
par(mfcol=c(2,2))

#Create UL plot
plot(dfdt$Timestamp, dfdt$Global_active_power, xlab="", ylab="Global Active Power", type="l")

#Create LL plot
plot(dfdt$Timestamp, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(dfdt$Timestamp, df$Sub_metering_2, type="l", col = "red")
points(dfdt$Timestamp, df$Sub_metering_3, type="l", col = "blue")
legend(x="topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lwd=2)

#Create UR plot
plot(dfdt$Timestamp,dfdt$Voltage,xlab="datetime", ylab="Voltage",type="l")

#Create LR plot
plot(dfdt$Timestamp, dfdt$Global_reactive_power, xlab= "datetime", ylab="Global Reactive Power", type="l")
dev.off()