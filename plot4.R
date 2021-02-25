# Download zip file

dataSource <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataSource, destfile="Individual household electric power consumption.zip")

# Unzip zip file

zipF <- "./Individual household electric power consumption.zip"
outdir <- "./IHEPC"
unzip(zipF, exdir=outdir)

# Read and subset data

data <- read.table(file.path("IHEPC","household_power_consumption.txt"),header=TRUE,sep=";")
datasubset <- subset(data,Date=="1/2/2007" | Date=="2/2/2007")

# Convert date and time character vectors to strptime, and move this vector to the left

library(dplyr)
datasubset$strp <- strptime(paste(datasubset$Date,datasubset$Time), format = "%d/%m/%Y %H:%M:%S")
datasubset <- datasubset %>% relocate("strp", .after = "Time")

# create png file and 2 x 2 grid for graphs

png(file="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))

# top left is plot #2
with(datasubset,plot(strp,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

# top right is new
datasubset$Voltage <- as.numeric(datasubset$Voltage)
with(datasubset,plot(strp,Voltage,type="l",xlab="datetime",ylab="Voltage"))

# bottom left is plot #3
with(datasubset,plot(strp,Sub_metering_1,type="l",xlab="",ylab="Energy Sub Metering"))
with(datasubset,lines(strp,Sub_metering_2,col="red"))
with(datasubset,lines(strp,Sub_metering_3,col="blue"))
with(datasubset,legend("topright",legend=c("Sub_metering_1","Sub_metering_1","Sub_metering_3"),lwd = 1, col=c("black","red","blue") ) )

# bottom right is new
datasubset$Global_reactive_power <- as.numeric(datasubset$Global_reactive_power)
with(datasubset,plot(strp,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))

dev.off()