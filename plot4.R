library("data.table")


wd<-getwd()
filepath<-file.path(wd,"data")

setwd(filepath)
#Reads in data from file
power_consumption <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Prevents histogram from printing in scientific notation
power_consumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Adding a column in a POSIXct date format
power_consumption[, datetime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#filter dates between the requested ones
power_consumption <- power_consumption[(datetime >= "2007-02-01") & (datetime < "2007-02-03")]

#creating plot in figure directory
filepath<-file.path(wd,"figure")
setwd(filepath)
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# ok.. this time 4 plots!

# topleft
plot(power_consumption[, datetime], power_consumption[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# topright
plot(power_consumption[, datetime],power_consumption[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# bottomleft
plot(power_consumption[, datetime], power_consumption[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power_consumption[, datetime], power_consumption[, Sub_metering_2], col="red")
lines(power_consumption[, datetime], power_consumption[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), bty="n", cex=.5) 

# bottomright
plot(power_consumption[, datetime], power_consumption[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

setwd(wd)