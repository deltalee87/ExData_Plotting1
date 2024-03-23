
ECD <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(ECD) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


JanStart <- subset(ECD,ECD$Date=="1/2/2007" | ECD$Date =="2/2/2007")
JanStart$Date <- as.Date(JanStart$Date, format="%d/%m/%Y")
JanStart$Time <- strptime(JanStart$Time, format="%H:%M:%S")
JanStart[1:1440,"Time"] <- format(JanStart[1:1440,"Time"],"2007-02-01 %H:%M:%S")
JanStart[1441:2880,"Time"] <- format(JanStart[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


plot(JanStart$Time,JanStart$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering", axes=FALSE)
with(JanStart,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(JanStart,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(JanStart,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# annotating graph
title(main="Energy sub-metering")
axis.POSIXct(1, JanStart$Time, format = "%a")
axis(2)
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()