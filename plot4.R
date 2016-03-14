if(!file.exists("household_power_consumption.txt")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}

HHPWR <- read.table("household_power_consumption.txt", sep=";", header=T)
twoday <- HHPWR[(HHPWR$Date == "1/2/2007")| (HHPWR$Date=="2/2/2007"),]
twoday$Date <- as.Date(twoday$Date, format="%d/%m/%Y")
twoday <- transform(twoday, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
twoday$Sub_metering_1 <- as.numeric(as.character(twoday$Sub_metering_1))
twoday$Sub_metering_2 <- as.numeric(as.character(twoday$Sub_metering_2))
twoday$Sub_metering_3 <- as.numeric(as.character(twoday$Sub_metering_3))

par(mfrow=c(2,2))
plot(twoday$timestamp, as.numeric(as.character(twoday$Global_active_power)),type="l", xlab = "", ylab ="GLobal Active Power (kilowatts)")
plot(twoday$timestamp, as.numeric(as.character(twoday$Voltage)),type="l", xlab = "datetime", ylab ="Voltage")

plot(twoday$timestamp,twoday$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(twoday$timestamp,twoday$Sub_metering_2,col="red")
lines(twoday$timestamp,twoday$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

plot(twoday$timestamp,twoday$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", width=480, height = 480)
dev.off()