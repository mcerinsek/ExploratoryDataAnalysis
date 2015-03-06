library(dplyr)
library(sqldf)
Sys.setenv(LANG = "en")

# COMMENT: My system default language is Slovenian and I haven't found
# the solution for changing the day names into English.

data = read.csv.sql('household_power_consumption.txt', sep = ';', 
                    sql = 'select Global_active_power, Date, Time from file
                    where Date = "1/2/2007" or Date = "2/2/2007"')

data[data == '?'] = NA
data$Time = strptime(paste(data$Date, data$Time), '%d/%m/%Y %H:%M:%S')

png('plot2.png', width = 480, height = 480)
plot(y = data$Global_active_power, x = data$Time, main = '', type = 'l',
     ylab = 'Global Active Power (kilowatts)', xlab = '')
dev.off()