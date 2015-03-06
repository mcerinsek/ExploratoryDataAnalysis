library(dplyr)
library(sqldf)
Sys.setenv(LANG = "en")

# COMMENT: My system default language is Slovenian and I haven't found
# the solution for changing the day names into English.

data = read.csv.sql('household_power_consumption.txt', sep = ';', 
                    sql = 'select Sub_metering_1, Sub_metering_2, 
                    Sub_metering_3, Date, Time from file
                    where Date = "1/2/2007" or Date = "2/2/2007"')

data[data == '?'] = NA
data$Time = strptime(paste(data$Date, data$Time), '%d/%m/%Y %H:%M:%S')

png('plot3.png', width = 480, height = 480)
plot(y = data$Sub_metering_1, x = data$Time, main = '', type = 'l',
     ylab = 'Energy sub metering', xlab = '')
lines(y = data$Sub_metering_2, x = data$Time, col = 'red')
lines(y = data$Sub_metering_3, x = data$Time, col = 'blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'), lty = c(1,1,1))
dev.off()