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
png("plot3.png", width=480, height=480)

# plotting plot3
plot(power_consumption[, datetime], power_consumption[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power_consumption[, datetime], power_consumption[, Sub_metering_2],col="red")
lines(power_consumption[, datetime], power_consumption[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.off()

#return to original wd
setwd(wd)