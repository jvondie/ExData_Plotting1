if(!file.exists("household_power_consumption.txt")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}

HHPWR <- read.table("household_power_consumption.txt", sep=";", header=T)
twoday <- HHPWR[(HHPWR$Date == "1/2/2007")| (HHPWR$Date=="2/2/2007"),]
hist(as.numeric(as.character(twoday$Global_active_power)), main = paste("Global Active Power"), ylab = "Frequency", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png, file= "plot1.png", width = 480, height=480)
dev.off()
