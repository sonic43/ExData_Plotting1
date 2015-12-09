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

#draw Global_active_power & date plot
png("plot2.png", width = 480, height = 480)
with(data_int, plot(dateTime, Global_active_power, 
                    type = "l",
                    xlab = "",
                    ylab = "Global Active Power (kilowatts)"))
dev.off()