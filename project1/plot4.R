library(dplyr)
library(sqldf)
Sys.setenv(LANG = "en")

# COMMENT: My system default language is Slovenian and I haven't found
# the solution for changing the day names into English.

data = read.csv.sql('household_power_consumption.txt', sep = ';', 
                    sql = 'select Global_active_power, Sub_metering_1, Sub_metering_2, 
                    Sub_metering_3, Voltage, Global_reactive_power, Date, Time from file
                    where Date = "1/2/2007" or Date = "2/2/2007"')

data[data == '?'] = NA
data$Time = strptime(paste(data$Date, data$Time), '%d/%m/%Y %H:%M:%S')

png('plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))

plot(y = data$Global_active_power, x = data$Time, main = '', type = 'l',
     ylab = 'Global Active Power (kilowatts)', xlab = '')

plot(y = data$Voltage, x = data$Time, main = '', type = 'l',
     ylab = 'Voltage', xlab = 'datetime')

plot(y = data$Sub_metering_1, x = data$Time, main = '', type = 'l',
     ylab = 'Energy sub metering', xlab = '')
lines(y = data$Sub_metering_2, x = data$Time, col = 'red')
lines(y = data$Sub_metering_3, x = data$Time, col = 'blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'), lty = c(1,1,1))

plot(y = data$Global_reactive_power, x = data$Time, main = '', type = 'l',
     xlab = 'datetime', ylab = 'Global_reactive_power')
dev.off()