ECDF <- "household_power_consumption.txt"
ECD <- read.table(ECDF, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
JanStart <- ECD[ECD$Date %in% c("1/2/2007","2/2/2007") ,]

datetime <- strptime(paste(JanStart$Date, JanStart$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
GAP <- as.numeric(JanStart$Global_active_power)
GRP <- as.numeric(JanStart$Global_reactive_power)
voltage <- as.numeric(JanStart$Voltage)
subMetering1 <- as.numeric(JanStart$Sub_metering_1)
subMetering2 <- as.numeric(JanStart$Sub_metering_2)
subMetering3 <- as.numeric(JanStart$Sub_metering_3)


png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, GAP, type="l", xlab="", ylab="Global Active Power", cex=0.2, axes=FALSE)
axis(2)
axis.POSIXct(1, datetime, format = "%a")
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage", axes=FALSE)
axis(2)
axis.POSIXct(1, datetime, format = "%a")
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="", axes=FALSE)
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, GRP, type="l", xlab="datetime", ylab="Global_reactive_power", axes=FALSE)
axis(2)
axis.POSIXct(1, datetime, format = "%a")
dev.off()