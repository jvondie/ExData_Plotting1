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
plot(twoday$timestamp, as.numeric(as.character(twoday$Global_active_power)),type="l", xlab = "", ylab ="GLobal Active Power (kilowatts)")
dev.copy(png, file= "plot2.png", width = 480, height=480)
dev.off()

