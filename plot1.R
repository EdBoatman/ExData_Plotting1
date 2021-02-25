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

# PLOT 1
# ------

# convert Global Active Power from character to numeric

datasubset$Global_active_power <- as.numeric(datasubset$Global_active_power)

# create histogram

png(file="plot1.png", width=480, height=480, units="px")
hist(datasubset$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()