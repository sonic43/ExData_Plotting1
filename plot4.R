#Check integrating data set is whether exist or not
if (!exists("data_int")){
      fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileUrl, "data_total.zip")
      unzip("data_total.zip")
      data_total <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
      data_int <- subset(data_total, Date %in% c("1/2/2007", "2/2/2007"))
      for (i in 3:9) data_int[, i] <- as.numeric(data_int[, i])
      data_int$dateTime <- strptime(paste(data_int$Date, data_int$Time), "%d/%m/%Y %H:%M:%S")
}

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

#top-left
with(data_int, plot(dateTime, Global_active_power, 
                    type = "l",
                    xlab = "",
                    ylab = "Global Active Power"))

#top-right
with(data_int, plot(dateTime, Voltage, 
                    type = "l",
                    xlab = "datetime",
                    ylab = "Voltage"))

#bottom-left 
with(data_int,plot(dateTime, Sub_metering_1,
                   type = "l", col = "black",
                   xlab = "", ylab = "Energy sub metering"))
with(data_int, lines(dateTime, Sub_metering_2, col = "red"))
with(data_int, lines(dateTime, Sub_metering_3, col = "blue"))
#different from plot3, remember to remove legend border
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), bty = "n")

#bottom-right
with(data_int, plot(dateTime, Global_reactive_power, 
                    type = "l",
                    xlab = "datetime",
                    ylab = "Global_reactive_power"))
dev.off()
