library("data.table")


wd<-getwd()
filepath<-file.path(wd,"data")

setwd(filepath)
#Reads in data from file
power_consumption <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Prevents histogram from printing in scientific notation
power_consumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#make the date column a datetype
power_consumption[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#filter dates between the requested ones
power_consumption <- power_consumption[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#creating plot in figure directory
filepath<-file.path(wd,"figure")
setwd(filepath)
png("plot1.png", width=480, height=480)

## creating plot1
hist(power_consumption[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()

#return to original wd
setwd(wd)