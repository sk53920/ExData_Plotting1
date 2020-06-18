library(dplyr)
library(lubridate)

#This script will create output a histogram of global active power to working directory.

#Read file located in working directory

fulltbl <- fread("household_power_consumption.txt", sep=";")

#Filter data table to relevant date range (2007-02-01 to 2007-02-02) and convert data columns to numeric
df <- fulltbl %>% mutate(Date=dmy(Date)) %>% filter(Date>="2007-02-01" & Date <="2007-02-02")
df[,3:9] <- lapply(df[,3:9], as.numeric)

#Create histogram of global active power 
png("plot1.png", width=480, height=480, units="px")
hist(df$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()


